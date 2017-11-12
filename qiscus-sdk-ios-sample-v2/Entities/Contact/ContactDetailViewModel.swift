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
    case picture
    case info
}

protocol ContactDetailViewModelItem {
    var type: ContactDetailViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class ContactDetailViewModel: NSObject {
    var items = [ContactDetailViewModelItem]()
    
    // this email variable must be set from caller class
    var email: String = "" {
        didSet {
            self.setup()
        }
    }
    
    func setup() {
        guard let contact = ContactList(data: QUser.all()) else { return }
        guard let filterData = contact.contacts.filter({ $0.email == self.email }).first else {
            return
        }
        
        // picture section
        let pictureItem = ContactDetailViewModelPictureItem(avatarURL: filterData.avatarURL!)
        items.append(pictureItem)
        
        // info name section
        let infoNameItem = ContactDetailViewModelInfoItem(info: ["Name": filterData.name!])
        items.append(infoNameItem)
        
        // info email section
        let infoEmailItem = ContactDetailViewModelInfoItem(info: ["Email": filterData.email!])
        items.append(infoEmailItem)
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
        case .picture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ContactPictureCell.identifier, for: indexPath) as? ContactPictureCell {
                    cell.item = item
                    return cell
            }
        case .info:
            if let item = item as? ContactDetailViewModelInfoItem, let cell = tableView.dequeueReusableCell(withIdentifier: ContactDetailCell.identifier, for: indexPath) as? ContactDetailCell {
                cell.item = item.info
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
class ContactDetailViewModelPictureItem: ContactDetailViewModelItem {
    var type: ContactDetailViewModelItemType {
        return .picture
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var rowCount: Int {
        return 1
    }
    
    var avatarURL: String
    
    init(avatarURL: String) {
        self.avatarURL = avatarURL
    }
}

class ContactDetailViewModelInfoItem: ContactDetailViewModelItem {
    var type: ContactDetailViewModelItemType {
        return .info
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var rowCount: Int {
        return 1
    }
    
    var info: [String: String]
    
    init(info: [String: String]) {
        self.info = info
    }
}
