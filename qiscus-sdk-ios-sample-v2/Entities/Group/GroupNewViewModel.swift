//
//  GroupNewViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit
import Qiscus

protocol GroupNewViewDelegate {
    func itemsDidChanged(contacts: [Contact])
    func filterSearchDidChanged()
}

class GroupNewViewModel: NSObject {
    fileprivate var delegate: GroupNewViewDelegate?
    var items = [Contact]()
    var itemSelecteds = [Contact]() {
        didSet {
            delegate?.itemsDidChanged(contacts: itemSelecteds)
        }
    }
    var filteredData = [Contact]()
    
    init(delegate: GroupNewViewDelegate) {
        super.init()
        
        self.delegate = delegate
        self.setup()
    }

    func setup() {
        var contacts = ContactLocal.instance.contacts
        if contacts.isEmpty {
            guard let data = dataFromURL(of: Helper.URL_CONTACTS) else { return }
            guard let contactList = ContactList(data: data) else { return }
            contacts = contactList.contacts
        }
        
        self.items          = contacts
        self.filteredData   = contacts
    }
}

extension GroupNewViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.filteredData[indexPath.row]
        if !(self.itemSelecteds.contains(where: { $0.email == contact.email })) {
            self.itemSelecteds.append(contact)
            tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView.checkImage(true)

        } else {
            if let idx = self.itemSelecteds.index(where: { $0.email == contact.email }) {
                self.itemSelecteds.remove(at: idx)
                tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView.checkImage(false)
            }
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Register collection view
        let screenWidth: CGFloat    = CGFloat.screenWidth
        let sectionHeight: CGFloat  = 80.0
        let itemWidth: CGFloat      = 65.0
        let headerView              = UIView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: screenWidth,
                                                           height: sectionHeight))
        
        let layout              = UICollectionViewFlowLayout()
        layout.itemSize         = CGSize(width: itemWidth,
                                         height: sectionHeight)
        layout.scrollDirection  = .horizontal
        
        let collectionView  = UICollectionView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: screenWidth,
                                                             height: sectionHeight), collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ParticipantCollCell.nib, forCellWithReuseIdentifier: ParticipantCollCell.identifier)
        collectionView.backgroundColor = UIColor.white
        headerView.addSubview(collectionView)
        
        // MARK: - Add border bottom in layer
        let border: CALayer = CALayer()
        
        border.frame                = CGRect(x: 0, y: sectionHeight, width: screenWidth, height: 1)
        border.backgroundColor      = UIColor(red: 228/255, green: 227/255, blue: 229/255, alpha: 1).cgColor
        headerView.backgroundColor  = UIColor.white
        headerView.layer.addSublayer(border)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.itemSelecteds.count > 0 {
            return 80.0
            
        } else {
            return 0
        }
    }
}

extension GroupNewViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell {
            let contact     = self.filteredData[indexPath.row]
            let selected    = self.itemSelecteds.contains(where: { $0.email == contact.email})
            
            cell.item           = contact
            cell.accessoryView  = UIImageView.checkImage(selected)
            
            tableView.tableFooterView = UIView()
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
}

extension GroupNewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.itemSelecteds.remove(at: indexPath.row)
    }
}

extension GroupNewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemSelecteds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticipantCollCell.identifier, for: indexPath) as? ParticipantCollCell {
            cell.item = self.itemSelecteds[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension GroupNewViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? items : items.filter({ (contact: Contact) -> Bool in
                return contact.name!.lowercased().contains(searchText.lowercased())
            })
            
            delegate?.filterSearchDidChanged()
        }
    }
}
