//
//  ChatModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

class Chat {
    var name: String?
    var avatarURL: String?
    var typingUser: String?
    var roomId: Int?
    var isGroup: Bool?
    var unreadCount: Int?
    var lastCommentText: String?
    var participants = [Participant]()
    
    init?(data body: QRoom) {
        self.name = body.name
        self.avatarURL = body.avatarURL
        self.typingUser = body.typingUser
        self.roomId = body.id
        self.isGroup = (body.type == QRoomType.group)
        self.unreadCount = body.unreadCount
        self.lastCommentText = (body.lastComment?.text)!
        
        let tmpParticipants = body.participants
        for tmp in tmpParticipants {
            if let user = tmp.user {
                self.participants.append(Participant(name: user.fullname,
                                                     email: user.email,
                                                     avatarURL: user.avatarURL)
                )
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
