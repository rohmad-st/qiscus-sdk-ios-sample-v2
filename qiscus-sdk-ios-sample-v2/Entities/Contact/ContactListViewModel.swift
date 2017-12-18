//
//  ContactListViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit
import Qiscus

protocol ContactListViewDelegate {
    func showLoading(_ message: String)
    func didFailedUpdated(_ message: String)
    func didFinishUpdated()
    func filterSearchDidChanged()
    func fetchingData()
    func fetchingDataDidFinished()
}

class ContactListViewModel: NSObject {
    var delegate: ContactListViewDelegate?
    var items = [Contact]()
    var filteredData = [Contact]()
    var pageNumber: Int = 1
    var isLastPage: Bool = false
    var isBusy: Bool = false
    
    func loadData() {
        self.delegate?.showLoading("Please wait...")
        self.isBusy = true
        self.items.removeAll()
        self.filteredData.removeAll()
        
        let contacts = ContactLocal.instance.contacts
        if contacts.isEmpty {
            Api.loadContacts(Helper.URL_CONTACTS, headers: Helper.headers, completion: { response in
                switch(response){
                case .failed(value: let message):
                    self.isBusy = false
                    self.delegate?.didFailedUpdated(message)
                    break
                    
                case .succeed(value: let data):
                    if let data = data as? [Contact] {
                        self.items.append(contentsOf: data)
                        self.filteredData.append(contentsOf: data)
                        self.isBusy = false
                        self.delegate?.didFinishUpdated()
                    }
                    break
                    
                default:
                    self.isBusy = false
                    break
                }
            })
            
        } else {
            self.isBusy = false
            self.items.append(contentsOf: contacts)
            self.filteredData.append(contentsOf: contacts)
            self.delegate?.didFinishUpdated()
        }
    }
    
    func fetchData() {
        guard !self.isLastPage else { return }
        
        print("fetch data is on page : \(self.pageNumber)")
        self.isBusy = true
        self.delegate?.fetchingData()
        Api.loadContacts(Helper.urlContacts(of: pageNumber), headers: Helper.headers, completion: { response in
            switch(response){
            case .failed(value: _):
                self.isBusy = false
                self.delegate?.fetchingDataDidFinished()
                break
                
            case .succeed(value: let data):
                if let data = data as? [Contact] {
                    if data.count == 0 { self.isLastPage = true }
                    self.isBusy = false
                    self.items.append(contentsOf: data)
                    self.filteredData.append(contentsOf: data)
                    self.delegate?.fetchingDataDidFinished()
                }
                break
                
            default:
                self.isBusy = false
                break
            }
        })
    }
    
    func showDialog(_ contact: Contact) -> Void {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let detailButton = UIAlertAction(title: "Contact Detail",
                                       style: .default,
                                       handler: { (action) -> Void in
                                        let targetVC = DetailContactVC()
                                        targetVC.contact = contact
                                        targetVC.hidesBottomBarWhenPushed = true
                                        openViewController(targetVC)
        })
        let chatButton = UIAlertAction(title: "Send Message",
                                       style: .default,
                                       handler: { (action) -> Void in
                                        chatWithUser(contact)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: { (action) -> Void in
                                            print("Cancel button tapped")
        })
        
        alertController.addAction(detailButton)
        alertController.addAction(chatButton)
        alertController.addAction(cancelButton)
        alertController.preferredAction = chatButton
        
        presentViewController(alertController)
    }
    
    @objc func chatWithStranger(_ sender: Any) {
        let alertController = UIAlertController(title: "Chat With Stranger",
                                                message: "Enter the unique id for your chat target ex: johnny@appleseed.com.",
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Unique ID"
        }
        
        let okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            guard let textField = alertController.textFields![0] as UITextField! else { return }
            if let field = textField.text {
                if !(field.isEmpty) {
                    chatWithUniqueId(field)
                }
            }
        })
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: { (action) -> Void in
                                            print("Cancel button tapped")
        })
        
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        alertController.preferredAction = okButton
        
        presentViewController(alertController)
    }
    
    func backgroundView() -> UIView {
        let bgView = UIView.backgroundView(UIImage(named: "ic_empty_contact")!,
                                           title: "Contact is Empty",
                                           description: "If you chat with stranger, it’ll automaticaly added to here",
                                           titleButton: "Chat With Stranger",
                                           iconButton: UIImage(named: "ic_stranger")!,
                                           target: self,
                                           action: #selector(chatWithStranger(_:)),
                                           btnWidth: 244)
        
        return bgView
    }
}

extension ContactListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDialog(self.filteredData[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !self.isBusy && !self.isLastPage else { return }
        
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            self.pageNumber += 1
            self.fetchData()
        }
    }
}

extension ContactListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if items.count > 0 {
            tableView.backgroundView?.isHidden  = true
            tableView.separatorStyle            = .singleLine
            
            return 1
            
        } else {
            tableView.backgroundView            = self.backgroundView()
            tableView.separatorStyle            = .none
            tableView.backgroundView?.isHidden  = self.isBusy
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell {
            cell.item = self.filteredData[indexPath.row]
            
            tableView.tableFooterView = UIView()
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ContactListViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? items : items.filter({ (contact: Contact) -> Bool in
                return contact.name!.lowercased().contains(searchText.lowercased())
            })
            
            delegate?.filterSearchDidChanged()
        }
    }
}

