//
//  GroupModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/18/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation

class Group {
    var name: String?
    var avatarURL: String?
    var participants = [Contact]()
    
    init?(name: String, avatarURL: String, participants: [Contact]) {
        self.name = name
        self.avatarURL = avatarURL
        self.participants = participants
    }
}
