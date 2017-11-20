//
//  ChatManager.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

public func chatWithRoomId(_ roomId: Int, isGroup: Bool = true, contact: Contact? = nil) -> Void {
    let chatView = Qiscus.chatView(withRoomId: roomId)
    
    if isGroup {
        chatView.titleAction = {
            let targetVC                        = DetailGroupVC() //DetailChatVC()
            targetVC.id                         = roomId
            targetVC.hidesBottomBarWhenPushed   = true
            chatView.navigationController?.pushViewController(targetVC, animated: true)
        }
        
    } else {
        chatView.titleAction = {
            guard let contact = contact else { return }
            
            let targetVC                        = DetailContactVC()
            targetVC.enableChatButton           = false
            targetVC.contact                    = contact
            
            targetVC.hidesBottomBarWhenPushed   = true
            chatView.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    
    chatView.setBackButton(withAction: {
        chatView.tabBarController?.selectedIndex = 0
        _ = chatView.navigationController?.popToRootViewController(animated: true)
    })
    
    chatView.hidesBottomBarWhenPushed = true
    chatView.setBackTitle()
    openViewController(chatView)
}


/*
 * {email} can be contains of email or uniqueId
 * but in this case we always use value of email
 */
public func chatWithUser(_ contact: Contact) {
    guard let email = contact.email else { return }
    let chatView = Qiscus.chatView(withUsers: [email])
    
    chatView.titleAction = {
        let targetVC                        = DetailContactVC()
        targetVC.enableChatButton           = false
        targetVC.contact                    = contact
        targetVC.hidesBottomBarWhenPushed   = true
        chatView.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    chatView.setBackButton(withAction: {
        chatView.tabBarController?.selectedIndex = 0
        _ = chatView.navigationController?.popToRootViewController(animated: true)
    })
    
    chatView.hidesBottomBarWhenPushed = true
    chatView.setBackTitle()
    openViewController(chatView)
}

// {uniqueId} can be contains of: email/userId/phone
public func chatWithUniqueId(_ uniqueId: String) {
    let chatView = Qiscus.chatView(withUsers: [uniqueId])
    
    chatView.titleAction = {}
    
    chatView.setBackButton(withAction: {
        chatView.tabBarController?.selectedIndex = 0
        _ = chatView.navigationController?.popToRootViewController(animated: true)
    })
    
    chatView.hidesBottomBarWhenPushed = true
    chatView.setBackTitle()
    openViewController(chatView)
}

public func createGroupChat(_ users: [String], title: String) {
    let chatView = Qiscus.createChatView(withUsers: users, title: title)

    chatView.titleAction = {
        let targetVC                        = DetailGroupVC()
        targetVC.id                         = chatView.chatRoom?.id
        targetVC.hidesBottomBarWhenPushed   = true
        chatView.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    chatView.setBackButton(withAction: {
        chatView.tabBarController?.selectedIndex = 0
        _ = chatView.navigationController?.popToRootViewController(animated: true)
    })
    
    chatView.hidesBottomBarWhenPushed = true
    chatView.setBackTitle()
    openViewController(chatView)
}
