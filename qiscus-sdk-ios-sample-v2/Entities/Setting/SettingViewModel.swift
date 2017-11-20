//
//  SettingViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/18/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit

class SettingViewModel: NSObject {
    var items = [ContactDetailViewModelItem]()
    
    override init() {
        let data = Preference.instance.getLocal()
        guard let name = data.username else { return }
        guard let avatarURL = data.avatarURL else { return }
        guard let email = data.email else { return }
        guard let contact = Contact(id: 0, name: name, avatarURL: avatarURL, email: email) else { return }
        
        // info contact section
        let infoContactItem = ContactDetailViewModelInfoItem(contact: contact)
        items.append(infoContactItem)
        
        // actions section
        let action: Action = Action(title: "Logout", icon: UIImage(named: "ic_logout")!, type: .logout)
        let chatActionItem = ContactDetailViewModelActionItem(action: action)
        items.append(chatActionItem)
    }
}

extension SettingViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        if item.type == .actions {
            if let action = item as? ContactDetailViewModelActionItem {
                guard let type = action.action.type else { return }
                
                if type == .logout {
                    Preference.instance.clearAll()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                        // start authenticate user
                        let app = UIApplication.shared.delegate as! AppDelegate
                        app.getBaseApp().validateUser()
                    })
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

extension SettingViewModel: UITableViewDataSource {
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
