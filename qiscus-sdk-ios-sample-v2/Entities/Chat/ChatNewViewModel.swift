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

protocol ChatNewViewModelItem {
    var type: ChatNewViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class ChatNewViewModel: NSObject {
    var items = [ChatNewViewModelItem]()
    
    override init() {
        guard let contact = ContactList(data: QRoom.all()) else { return }
        
        // create group
        let createGroupItem = ChatNewViewModelCreateGroupItem(target: UIViewController(), #selector(createGroup(_:)))
        items.append(createGroupItem)
        
        // create stranger
        let createStrangerItem = ChatNewViewModelCreateStrangerItem(target: UIViewController(), #selector(createStranger(_:)))
        items.append(createStrangerItem)
        
        let contacts = contact.contacts
        if !contacts.isEmpty {
            let contactItem = ChatNewViewModelContactsItem(contacts: contacts)
            items.append(contactItem)
        }
    }
    
    @objc func createGroup(_ sender: Any) {
        print("create group..")
    }
    
    @objc func createStranger(_ sender: Any) {
        print("create stranger..")
    }
}

extension ChatNewViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        switch item.type {
        case .createGroup:
            print("goto create group page...")
        case .createStranger:
            print("goto create stranger ...")
        case .contacts:
            if let item = item as? ChatNewViewModelContactsItem {
                let contact = item.contacts[indexPath.row]
                 print("chat with contact : \(contact.email!)")
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
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
                return cell
            }
            
        case .contacts:
            if let item = item as? ChatNewViewModelContactsItem, let cell = tableView.dequeueReusableCell(withIdentifier: SelectContactCell.identifier, for: indexPath) as? SelectContactCell {
                let contact = item.contacts[indexPath.row]
                cell.item = contact
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
    
    var target: Any
    var action: Selector
    
    init(target: Any, _ action: Selector) {
        self.target = target
        self.action = action
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
    
    var target: Any
    var action: Selector
    
    init(target: Any, _ action: Selector) {
        self.target = target
        self.action = action
    }
}

class ChatNewViewModelContactsItem: ChatNewViewModelItem {
    var type: ChatNewViewModelItemType {
        return .contacts
    }
    
    var sectionTitle: String {
        return "Contacts"
    }
    
    var rowCount: Int {
        return contacts.count
    }
    
    var contacts: [Contact]
    
    init(contacts: [Contact]) {
        self.contacts = contacts
    }
}
