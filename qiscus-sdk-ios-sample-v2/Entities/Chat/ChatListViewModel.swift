//
//  ChatListViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/11/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit
import Qiscus

class ChatListViewModel: NSObject {
    var items = [Chat]()
    
    override init() {
        super.init()
        
        var rooms = QRoom.all()
        if rooms.isEmpty {
            QChatService.roomList(withLimit: 100, page: 1, onSuccess: { (allRooms, totalRoom, currentPage, limit) in
                DispatchQueue.main.async {
                    rooms = QRoom.all()
                }
            }) { (error) in
                print("Failed load list rooms \(error)")
            }
        }
        
        guard let chat = ChatList(data: rooms) else { return }
        
        let chats = chat.chats
        if !chats.isEmpty {
            self.items.append(contentsOf: chats)
        }
    }
}

extension ChatListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat            = self.items[indexPath.row]
        guard let roomId    = chat.roomId else { return }
        guard let isGroup   = chat.isGroup else { return }
        
        // get email of target user from participants
        let myEmail = Preference.instance.getEmail()
        guard let filterParticipant = chat.participants.filter({ $0.email != myEmail }).first else {
            chatWithRoomId(roomId, isGroup: isGroup)
            return
        }
        
        chatWithRoomId(roomId, isGroup: isGroup, email: filterParticipant.email)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ChatListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell {
            let chat = self.items[indexPath.row]
            cell.item = chat
            
            return cell
        }
        
        return UITableViewCell()
    }
}
