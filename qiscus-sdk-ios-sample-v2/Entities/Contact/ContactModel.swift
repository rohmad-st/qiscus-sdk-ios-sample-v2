//
//  ContactModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus
import SwiftyJSON

class ContactLocal {
    var contacts = [Contact]()
    static let instance = ContactLocal()
    
    func setData(_ contacts: [Contact]) {
        self.contacts.append(contentsOf: contacts)
    }
}

public class Contact {
    var id: Int?
    var name: String?
    var avatarURL: String?
    var email: String?
    
    init(withJSON data: JSON) {        
        self.id = data["id"].intValue
        self.name = data["name"].stringValue
        self.avatarURL = data["avatar_url"].stringValue
        self.email = data["email"].stringValue
    }
    
    init?(user: QUser) {
        self.id = user.id
        self.name = user.fullname
        self.avatarURL = user.avatarURL
        self.email = user.email
    }
    
    init?(id: Int, name: String, avatarURL: String, email: String) {
        self.id = id
        self.name = name
        self.avatarURL = avatarURL
        self.email = email
    }
}
