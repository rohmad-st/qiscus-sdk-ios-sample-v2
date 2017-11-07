//
//  ChatListVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import Qiscus

class ChatListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var chats: Chats!
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupUI()
        self.getChatList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ChatListVC {
    func setupUI() -> Void {
        self.title = "Chat List"
        
        // MARK: - Register table & cell
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCellIdentifier")
    }
    
    func getChatList() -> Void {
        QChatService.roomList(withLimit: 100,
                              page: 1,
                              onSuccess: { (listRoom, totalRoom, currentPage, limit) in
                                var rooms: [Room] = []
                                listRoom.forEach({ (data) in
                                    let room = Room(name: data.name,
                                                    avatarURL: data.avatarURL,
                                                    typingUser: data.typingUser,
                                                    roomId: data.id,
                                                    isGroup: true,
                                                    unreadCount: data.unreadCount,
                                                    lastCommentText: (data.lastComment?.text)!)
                                    rooms.append(room)
                                })
                                
                                self.chats = Chats(withData: rooms)
                                self.tableView.reloadData()
                                
        }, onFailed: { (err) in
            print("Failed load chats: \(err)")
        })
    }
    
    func chatTarget(roomId: Int) -> Void {
        let view = Qiscus.chatView(withRoomId: roomId)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}

extension ChatListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roomId = self.chats.list[indexPath.row].roomId
        self.chatTarget(roomId: roomId)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ChatListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let chats = self.chats {
            return chats.list.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: "ChatCellIdentifier",
                                                    for: indexPath) as! ChatCell
        let row     = indexPath.row
        
        if let chats = self.chats {
            cell.chatNameLabel.text     = chats.list[row].name
            cell.lastMessageLabel.text  = chats.list[row].lastCommentText
        }
        
        self.tableView.tableFooterView = UIView()
        
        return cell
    }
}
