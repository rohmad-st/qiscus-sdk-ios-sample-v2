//
//  ChatListVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import Qiscus
import Alamofire

class ChatListVC: UIViewController, UILoadingView {
    
    @IBOutlet weak var tableView: UITableView!
    var chats: Chats!
    
    override func viewWillAppear(_ animated: Bool) {
        self.showWaiting(message: "Please wait...")
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
        self.title = "Chat"
        
        // MARK: - Register table & cell
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "ChatCellIdentifier")
        
        // add button in navigation right
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func getChatList() -> Void {
        QChatService.roomList(withLimit: 100,
                              page: 1,
                              onSuccess: { (listRoom, totalRoom, currentPage, limit) in
                                var rooms = [Room]()
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
                                self.dismissLoading()
                                
        }, onFailed: { (err) in
            self.showError(message: err)
            print("Failed load chats: \(err)")
        })
    }
    
    func chatTarget(roomId: Int, _ isGroup: Bool = true) -> Void {
        let chatView = Qiscus.chatView(withRoomId: roomId)
        
        chatView.titleAction = {
            let targetVC = DetailChatVC()
            targetVC.id = roomId
            targetVC.hidesBottomBarWhenPushed = true
            chatView.navigationController?.pushViewController(targetVC, animated: true)
        }
        
        chatView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatView, animated: true)
    }
    
    @objc func add(_ sender: Any) {
        print("login clicked...")
        let view = NewChatVC()
        
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension ChatListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = self.chats.list[indexPath.row]
        
        self.chatTarget(roomId: chat.roomId, chat.isGroup)
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
            // loadAsync is method that came from Qiscus SDK, so we (client) also possible to used it
            cell.avatarImageView.loadAsync(chats.list[row].avatarURL,
                                           placeholderImage: UIImage(named: "avatar"),
                                           header: Helper.headers)
            cell.chatNameLabel.text     = chats.list[row].name
            cell.lastMessageLabel.text  = chats.list[row].lastCommentText
            
            // set avatar image rounded
            let cellImageLayer: CALayer?    = cell.avatarImageView.layer
            let imageRadius: CGFloat        = CGFloat(cellImageLayer!.frame.size.height / 2)
            cellImageLayer!.cornerRadius    = imageRadius
            cellImageLayer!.masksToBounds   = true
        }
        
        self.tableView.tableFooterView = UIView()
        
        return cell
    }
}
