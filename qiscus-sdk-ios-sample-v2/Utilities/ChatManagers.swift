//
//  ChatManagers.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/10/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

//public func loadContacts(page:Int? = 1) -> [Contact] {
//    QChatService.roomList(withLimit: 100, page: 1, onSuccess: { (listRoom, totalRoom, currentPage, limit) in
//        listRoom.forEach({ (data) in
//            for p in data.participants {
//                guard let fullname = p.user?.fullname else { return }
//                guard let avatarURL = p.user?.avatarURL else { return }
//                guard let email = p.user?.email else { return }
//
//                let contact = Contact(name: fullname,
//                                      avatarURL: avatarURL,
//                                      phoneNumber: email,
//                                      email: email)
//
//                let arrUnique = listRoom.contains(where: { $0.name == fullname })
//                if !arrUnique { items.append(contact!) }
//            }
//        })
//
//        return items
//
//    }, onFailed: { (err) in
//        print("Failed load chats: \(err)")
//    })
//}

