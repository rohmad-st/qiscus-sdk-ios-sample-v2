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
    func showLoading(_ message: String)
    func didFailedUpdated(_ message: String)
    func didFinishUpdated()
}

class ChatListViewModel: NSObject {
    var delegate: ChatListViewDelegate?
    var items = [QRoom]() {
        didSet {
            self.delegate?.didFinishUpdated()
        }
    }
    
    func loadData() {
        self.delegate?.showLoading("Please wait...")
        self.items = QRoom.all()
        if self.items.isEmpty {
            QChatService.roomList(withLimit: 100, page: 1, onSuccess: { (allRooms, totalRoom, currentPage, limit) in
                DispatchQueue.main.async {
                    self.items = QRoom.all()
                }
                
            }, onFailed: { (error) in
                print("Failed load list rooms \(error)")
                self.delegate?.didFailedUpdated(error)
            })
        }
    }
    
    @objc func newChat(_ sender: Any) {
        let targetVC = NewChatVC()
        targetVC.hidesBottomBarWhenPushed = true
        openViewController(targetVC)
    }
    
    func backgroundView() -> UIView {
        return UIView.backgroundView(UIImage(named: "ic_empty_room")!,
                                     title: "You don’t have any room",
                                     description: "Start 1 on 1 chat with stranger or group chat with your friend.",
                                     titleButton: "New Chat",
                                     iconButton: UIImage(named: "ic_new_chat")!,
                                     target: self,
                                     action: #selector(newChat(_:)),
                                     btnWidth: 172)
    }
}

extension ChatListViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat    = self.items[indexPath.row]
        let roomId  = chat.id
        var contact: Contact?
        
        if chat.type == .single {
            let email = Preference.instance.getEmail()
            if let participant = chat.participants.filter("email != '\(email)'").first {
                if let user = participant.user {
                    contact = Contact(user: user)
                }
            }
        }
        
        chatWithRoomId(roomId, contact: contact)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ChatListViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.items.count > 0 {
            tableView.backgroundView?.isHidden  = true
            tableView.separatorStyle            = .singleLine

            return 1

        } else {
            tableView.backgroundView            = self.backgroundView()
            tableView.separatorStyle            = .none
            tableView.backgroundView?.isHidden  = false

            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell {
            let chat = self.items[indexPath.row]
            cell.room = chat
            
            tableView.tableFooterView = UIView()
            
            return cell
        }
        
        return UITableViewCell()
    }
}

