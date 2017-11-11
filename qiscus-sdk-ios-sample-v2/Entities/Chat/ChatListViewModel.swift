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
        
        guard let chat = ChatList(data: QRoom.all()) else { return }
        
        let chats = chat.chats
        if !chats.isEmpty {
            self.items.append(contentsOf: chats)
        }
    }
    
    func chatTarget(_ roomId: Int, isGroup: Bool = true, email: String? = "") -> Void {
        let chatView = Qiscus.chatView(withRoomId: roomId)
        
        if isGroup {
            chatView.titleAction = {
                let targetVC                        = DetailChatVC()
                targetVC.id                         = roomId
                targetVC.hidesBottomBarWhenPushed   = true
                chatView.navigationController?.pushViewController(targetVC, animated: true)
            }
            
        } else {
            chatView.titleAction = {
                guard let email = email else { return }
                
                let targetVC                        = DetailContactVC()
                targetVC.email                      = email
                targetVC.hidesBottomBarWhenPushed   = true
                chatView.navigationController?.pushViewController(targetVC, animated: true)
            }
        }
        
        chatView.hidesBottomBarWhenPushed = true
        openViewController(chatView)
    }
}

extension ChatListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat            = self.items[indexPath.row]
        guard let roomId    = chat.roomId else { return }
        guard let isGroup   = chat.isGroup else { return }
        
        // get email of target user from participants
        guard let email = chat.participants.flatMap({ $0.email }).last else {
            self.chatTarget(roomId, isGroup: isGroup)
            return
        }
        
        self.chatTarget(roomId, isGroup: isGroup, email: email)
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
