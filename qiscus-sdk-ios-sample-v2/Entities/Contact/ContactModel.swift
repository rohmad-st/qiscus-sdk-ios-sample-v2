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
    
    init?(data: [QUser]) {
        for user in data {
            if let contact = Contact(data: user) {
                if !(contact.email == Preference.instance.getEmail()) {
                    contacts.append(contact)
                }
            }
        }
    }
}

class Contact {
    var id: Int?
    var name: String?
    var avatarURL: String?
    var phoneNumber: String?
    var email: String?
    
    init?(data: QUser) {
        self.id = data.id
        self.name = data.fullname
        self.avatarURL = data.avatarURL
        self.phoneNumber = data.email
        self.email = data.email
    }
}
