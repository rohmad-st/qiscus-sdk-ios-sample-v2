//
//  ChatModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus
import SwiftyJSON

class Chat {
    var name: String?
    var avatarURL: String?
    var typingUser: String?
    var roomId: Int?
    var isGroup: Bool?
    var unreadCount: Int?
    var lastCommentText: String?
    var participants = [Participant]()
    
    init?(data: [String: Any]) {
        let dataJSON = JSON(data)
        let arrayConversation = dataJSON["data"].arrayValue
        
        for body in arrayConversation {
            self.name = body["name"].stringValue
            self.avatarURL = body["avatarURL"].stringValue
            self.typingUser = body["typingUser"].stringValue
            self.roomId = body["id"].intValue
            self.isGroup = body["isGroup"].boolValue
            self.unreadCount = body["unreadCount"].intValue
            self.lastCommentText = body["lastCommentText"].stringValue
            
            let tmpParticipants = body["participants"].arrayValue
            for tmp in tmpParticipants {
                self.participants.append(Participant(name: tmp["name"].stringValue,
                                                     email: tmp["email"].stringValue,
                                                     avatarURL: tmp["avatarURL"].stringValue))
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
