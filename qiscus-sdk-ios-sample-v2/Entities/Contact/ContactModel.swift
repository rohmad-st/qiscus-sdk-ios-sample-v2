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
    
    // in this app we always init data contacts in here
    // to catch our data in rest api
    // but actually you can also use QUser.all() to catch all data users
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["results"] as? [String: Any] {
                if let users = body["users"] as? [[String: Any]] {
                    contacts = users.map { Contact(json: $0) }
                }
            }
            
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
    
    init?(users: [QUser]) {
        for user in users {
            if let contact = Contact(user: user) {
                if !(contact.email == Preference.instance.getEmail()) {
                    contacts.append(contact)
                }
            }
        }
    }
}

public class Contact {
    var id: Int?
    var name: String?
    var avatarURL: String?
    var email: String?
    
    init(json: [String: Any]) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.avatarURL = json["avatar_url"] as? String
        self.email = json["email"] as? String
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
