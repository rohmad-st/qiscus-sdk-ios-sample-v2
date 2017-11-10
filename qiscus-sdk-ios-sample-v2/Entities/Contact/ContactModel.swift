//
//  ContactModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus


class ContactList {
    var contacts = [Contact]()
    
    init?(data: [QRoom]) {
        for tmpParticipants in data {
            for tmp in tmpParticipants.participants {
                if let user = tmp.user {
                    let fullname = user.fullname
                    let email = user.email
                    let arrUnique = contacts.contains(where: { $0.name == fullname })
                    let contact = Contact(name: fullname,
                                          avatarURL: user.avatarURL,
                                          phoneNumber: email,
                                          email: email)
                    
                    if !arrUnique { contacts.append(contact!) }
                }
            }
        }
    }
}

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
