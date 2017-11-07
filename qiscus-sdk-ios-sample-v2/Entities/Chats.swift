//
//  Chats.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation

struct Room {
    var name: String = ""
    var avatarURL: String = ""
    var typingUser: String = ""
    var roomId: Int = -1
    var isGroup: Bool = false
    var unreadCount: Int = 0
    var lastCommentText: String = ""
}

class Chats {
    var list: [Room] = []
    
    init(withData data: [Room]) {
        self.list = data
    }
}
