//
//  GroupDetailViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/18/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit
import Qiscus

enum GroupDetailViewModelItemType {
    case infoGroup
    case participants
}

protocol GroupDetailViewModelItem {
    var type: GroupDetailViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class GroupDetailViewModel: NSObject {
    var items = [GroupDetailViewModelItem]()
    var id: Int? {
        didSet {
            self.setup()
        }
    }
    
    private func setup() {
        guard let id = self.id else { return }
        guard let room = QRoom.room(withId: id) else { return }
        let participant = Chat(data: room)
        guard let participants = participant?.participants else { return }
        
        // info group
        let infoGroupItem = GroupDetailViewModelInfoItem(name: room.name, avatarURL: room.avatarURL)
        items.append(infoGroupItem)
        
        // participants
        let participantItem = GroupDetailViewModelParticipantsItem(participants: participants)
        items.append(participantItem)
    }
}

extension GroupDetailViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        switch item.type {
        case .infoGroup:
            break
            
        case .participants:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title   = items[section].sectionTitle
        let view    = UIView.headerInTableView(title)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = items[section]
        switch item.type {
        case .participants:
            return 50.0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        switch item.type {
        case .participants:
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 0)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.section]
        switch item.type {
        case .infoGroup:
            return 138.0
        case .participants:
            return 76.0
        }
    }
}

extension GroupDetailViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .infoGroup:
            if let cell = tableView.dequeueReusableCell(withIdentifier: GroupPictureCell.identifier, for: indexPath) as? GroupPictureCell {
                cell.item = item
                
                tableView.tableFooterView = UIView()
                
                return cell
            }
            
        case .participants:
            if let item = item as? GroupDetailViewModelParticipantsItem, let cell = tableView.dequeueReusableCell(withIdentifier: ParticipantCell.identifier, for: indexPath) as? ParticipantCell {
                let participant = item.participants[indexPath.row]
                cell.item       = participant
                
                tableView.tableFooterView = UIView()
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

class GroupDetailViewModelInfoItem: GroupDetailViewModelItem {
    var type: GroupDetailViewModelItemType {
        return .infoGroup
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var avatarURL: String
    
    init(name: String, avatarURL: String) {
        self.name = name
        self.avatarURL = avatarURL
    }
}

class GroupDetailViewModelParticipantsItem: GroupDetailViewModelItem {
    var type: GroupDetailViewModelItemType {
        return .participants
    }
    
    var sectionTitle: String {
        return "PARTICIPANTS"
    }
    
    var rowCount: Int {
        return participants.count
    }
    
    var participants: [Participant]
    
    init(participants: [Participant]) {
        self.participants = participants
    }
}
