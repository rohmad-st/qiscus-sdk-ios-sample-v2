//
//  ChatModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

class ChatList {
    var chats = [Chat]()
    
    init?(data: [QRoom]) {
        for body in data {
            guard let chat = Chat(data: body) else { return }
            chats.append(chat)
        }
    }
}

class Chat {
    var name: String?
    var avatarURL: String?
    var typingUser: String?
    var roomId: Int?
    var isGroup: Bool?
    var unreadCount: Int?
    var lastCommentText: String?
    var date: String?
    var time: String?
    var participants = [Contact]()
    //var participants = [Participant]()
    
    init?(data body: QRoom) {
        self.name = body.name
        self.avatarURL = body.avatarURL
        self.typingUser = body.typingUser
        self.roomId = body.id
        self.isGroup = (body.type == QRoomType.group)
        self.unreadCount = body.unreadCount
        self.lastCommentText = body.lastComment?.text
        self.date = body.lastComment?.date
        self.time = body.lastComment?.time
        
        let tmpParticipants = body.participants
        for tmp in tmpParticipants {
            if let user = tmp.user {
                guard let contact = Contact(user: user) else { return }
                self.participants.append(contact)
            }
        }
    }
}

class Participant {
    var name: String?
    var email: String?
    var avatarURL: String?
    
    init(name: String, email: String, avatarURL: String) {
        self.name = name
        self.email = email
        self.avatarURL = avatarURL
    }
}
