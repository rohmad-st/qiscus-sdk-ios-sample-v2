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
        guard let contact = ContactList(data: QUser.all()) else { return }
        
        // create group
        let createGroupItem = ChatNewViewModelCreateGroupItem()
        items.append(createGroupItem)

        // create stranger
        let createStrangerItem = ChatNewViewModelCreateStrangerItem()
        items.append(createStrangerItem)
        
        let contacts = contact.contacts
        if !contacts.isEmpty {
            let contactItem = ChatNewViewModelContactsItem(contacts: contacts)
            items.append(contactItem)
        }
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
            let targetVC = NewStrangerVC()
            openViewController(targetVC)
            
        case .contacts:
            if let item = item as? ChatNewViewModelContactsItem {
                let contact = item.contacts[indexPath.row]
                guard let email = contact.email else { return }
                print("Creating 1-to-1 chat with: \(email)")
                chatWithUser(email)
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
