//
//  ContactDetailViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/11/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

enum ContactDetailViewModelItemType {
    case infoContact
    case actions
}

protocol ContactDetailViewModelItem {
    var type: ContactDetailViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class ContactDetailViewModel: NSObject {
    var items = [ContactDetailViewModelItem]()
    
    // this contact variable must be set from caller class
    var contact: Contact? {
        didSet {
            self.setup()
        }
    }
    var enableChatButton: Bool? = true
    
    func setup() {
        guard let contact = self.contact else { return }
        
        // info contact section
        let infoContactItem = ContactDetailViewModelInfoItem(contact: contact)
        items.append(infoContactItem)
        
        // actions section
        let action: Action = Action(title: "Start Chat", icon: UIImage(named: "ic_room_list")!, type: .chat, enable: enableChatButton!)
        let chatActionItem = ContactDetailViewModelActionItem(action: action)
        items.append(chatActionItem)
    }
}

extension ContactDetailViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        if item.type == .actions {
            if let action = item as? ContactDetailViewModelActionItem {
                guard let enable = action.action.enable else { return }
                guard let type = action.action.type else { return }
                guard let contact = contact else { return }
                guard type == .chat else { return }
                
                if enable {
                    chatWithUser(contact)
                } else {
                    popViewController()
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = items[section]
        switch item.type {
        case .actions:
            return 32.0
        default:
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.section]
        switch item.type {
        case .infoContact:
            return 152.0
        case .actions:
            return 45.0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

extension ContactDetailViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .infoContact:
            if let item = item as? ContactDetailViewModelInfoItem, let cell = tableView.dequeueReusableCell(withIdentifier: ContactPictureCell.identifier, for: indexPath) as? ContactPictureCell {
                cell.item = item.contact
                
                tableView.tableFooterView = UIView()
                
                return cell
            }
        case .actions:
            if let item = item as? ContactDetailViewModelActionItem, let cell = tableView.dequeueReusableCell(withIdentifier: ActionCell.identifier, for: indexPath) as? ActionCell {
                cell.item = item.action
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
class ContactDetailViewModelInfoItem: ContactDetailViewModelItem {
    var type: ContactDetailViewModelItemType {
        return .infoContact
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var rowCount: Int {
        return 1
    }
    
    var contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
}

class ContactDetailViewModelActionItem: ContactDetailViewModelItem {
    var type: ContactDetailViewModelItemType {
        return .actions
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var rowCount: Int {
        return 1
    }
    
    var action: Action
    
    init(action: Action) {
        self.action = action
    }
}
