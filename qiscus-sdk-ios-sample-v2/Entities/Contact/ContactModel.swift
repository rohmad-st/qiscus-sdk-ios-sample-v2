//
//  ContactModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation

class Contact {
    var name: String?
    var avatarURL: String?
    var phoneNumber: String?
    var email: String?
    
    init?(name: String, avatarURL: String, phoneNumber: String, email: String) {
        self.name = name
        self.avatarURL = avatarURL
        self.phoneNumber = phoneNumber
        self.email = email
    }
}
