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

protocol ChatListViewDelegate {
    func didFinishUpdated()
}

class ChatListViewModel: NSObject {
    var delegate: ChatListViewDelegate?
    var items = [Chat]()
    
    func loadData() {
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
        self.items.removeAll()
        
        let chats = chat.chats
        if !chats.isEmpty {
            self.items.append(contentsOf: chats)
        }
        
        self.delegate?.didFinishUpdated()
    }
    
    @objc func newChat(_ sender: Any) {
        let targetVC = NewChatVC()
        targetVC.hidesBottomBarWhenPushed = true
        openViewController(targetVC)
    }
}

extension ChatListViewModel: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.items.count > 0 {
            tableView.backgroundView?.isHidden = true
            return 1
            
        } else {
            tableView.backgroundView = UIView.backgroundReload(UIImage(named: "ic_empty_room")!,
                                                               title: "You don’t have any room",
                                                               description: "Start 1 on 1 chat with stranger or group chat with your friend.",
                                                               titleButton: "New Chat",
                                                               iconButton: UIImage(named: "ic_new_chat")!,
                                                               target: self,
                                                               action: #selector(newChat(_:)),
                                                               btnWidth: 172)
            tableView.separatorStyle            = .none
            tableView.backgroundView?.isHidden  = false
            
            return 0
        }
    }
    
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
        
            tableView.tableFooterView = UIView()
            
            return cell
        }
        
        return UITableViewCell()
    }
}
