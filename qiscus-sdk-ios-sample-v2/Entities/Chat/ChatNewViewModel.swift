//
//  ChatNewViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/10/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit
import Qiscus

enum ChatNewViewModelItemType {
    case createGroup
    case createStranger
    case contacts
}

protocol ChatNewViewDelegate {
    func showLoading(_ message: String)
    func didFailedUpdated(_ message: String)
    func didFinishUpdated()
    func needLoadData()
}

protocol ChatNewViewModelItem {
    var type: ChatNewViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class ChatNewViewModel: NSObject {
    var items = [ChatNewViewModelItem]()
    var delegate: ChatNewViewDelegate?
    
    func loadData() {
        self.items.removeAll()
        
        let contacts = ContactLocal.instance.contacts
        if contacts.isEmpty {
            self.delegate?.showLoading("Please wait...")
            Api.loadContacts(Helper.URL_CONTACTS, headers: Helper.headers, completion: { response in
                switch(response){
                case .failed(value: let message):
                    self.delegate?.didFailedUpdated(message)
                    break
                case .succeed(value: _):
                    self.delegate?.needLoadData()
                    break
                default:
                    break
                }
            })
            
        } else {
            let createGroupItem = ChatNewViewModelCreateGroupItem()
            items.append(createGroupItem)
            
            // create stranger
            let createStrangerItem = ChatNewViewModelCreateStrangerItem()
            items.append(createStrangerItem)
            
            // list contacts
            let contactItem = ChatNewViewModelContactsItem(contacts: contacts)
            items.append(contactItem)
            self.delegate?.didFinishUpdated()
        }
    }
    
    func chatWithStranger() {
        let alertController = UIAlertController(title: "Chat With Stranger",
                                                message: "Enter the unique id for your chat target ex: \"demo@qiscus.com\".",
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
}

extension ChatNewViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        switch item.type {
        case .createGroup:
            let targetVC = NewGroupVC()
            openViewController(targetVC)
            
        case .createStranger:
            self.chatWithStranger()
            
        case .contacts:
            if let item = item as? ChatNewViewModelContactsItem {
                let contact = item.contacts[indexPath.row]
                guard let email = contact.email else { return }
                print("Creating 1-to-1 chat with: \(email)")
                chatWithUser(contact)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = items[section]
        switch item.type {
        case .createGroup:
            return 15.0
            
        case .createStranger:
            return 0.0
            
        case .contacts:
            return 50.0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title   = items[section].sectionTitle
        let view    = UIView.headerInTableView(title)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        switch item.type {
        case .createGroup:
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 63, bottom: 0, right: 0)
            }
            
        case .createStranger:
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
            
        case .contacts:
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 78, bottom: 0, right: 0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (items[indexPath.section].type == .contacts) {
            return 76.0
        }
        
        return UITableViewAutomaticDimension
    }
}

extension ChatNewViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .createGroup:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CreateGroupCell.identifier, for: indexPath) as? CreateGroupCell {
                cell.item = item
                return cell
            }

        case .createStranger:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CreateStrangerCell.identifier, for: indexPath) as? CreateStrangerCell {
                cell.item = item
                
                tableView.tableFooterView = UIView()
                
                return cell
            }
        
        case .contacts:
            if let item = item as? ChatNewViewModelContactsItem, let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell {
                let contact = item.contacts[indexPath.row]
                cell.item = contact
                
                tableView.tableFooterView = UIView()
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}

// MARK: - Handle response of each cell
class ChatNewViewModelCreateGroupItem: ChatNewViewModelItem {
    var type: ChatNewViewModelItemType {
        return .createGroup
    }

    var sectionTitle: String {
        return ""
    }

    var rowCount: Int {
        return 1
    }
}

class ChatNewViewModelCreateStrangerItem: ChatNewViewModelItem {
    var type: ChatNewViewModelItemType {
        return .createStranger
    }

    var sectionTitle: String {
        return ""
    }

    var rowCount: Int {
        return 1
    }
}

class ChatNewViewModelContactsItem: ChatNewViewModelItem {
    var type: ChatNewViewModelItemType {
        return .contacts
    }
    
    var sectionTitle: String {
        return "CONTACTS"
    }
    
    var rowCount: Int {
        return contacts.count
    }
    
    var contacts: [Contact]
    
    init(contacts: [Contact]) {
        self.contacts = contacts
    }
}
