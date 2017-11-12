//
//  ChatManager.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

public func chatWithRoomId(_ roomId: Int, isGroup: Bool = true, email: String? = "") -> Void {
    let chatView = Qiscus.chatView(withRoomId: roomId)
    
    if isGroup {
        chatView.titleAction = {
            let targetVC                        = DetailChatVC()
            targetVC.id                         = roomId
            targetVC.hidesBottomBarWhenPushed   = true
            chatView.navigationController?.pushViewController(targetVC, animated: true)
        }
        
    } else {
        chatView.titleAction = {
            guard let email = email else { return }
            
            let targetVC                        = DetailContactVC()
            targetVC.email                      = email
            targetVC.hidesBottomBarWhenPushed   = true
            chatView.navigationController?.pushViewController(targetVC, animated: true)
        }
    }
    
    chatView.setBackButton(withAction: {
        chatView.tabBarController?.selectedIndex = 0
        _ = chatView.navigationController?.popToRootViewController(animated: true)
    })
    
    chatView.hidesBottomBarWhenPushed = true
    openViewController(chatView)
}


// chat with user, email can be insert with unique id
public func chatWithUser(_ email: String) {
    let chatView = Qiscus.chatView(withUsers: [email])
    
    chatView.titleAction = {
        let targetVC                        = DetailContactVC()
        targetVC.email                      = email
        targetVC.hidesBottomBarWhenPushed   = true
        chatView.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    chatView.setBackButton(withAction: {
        chatView.tabBarController?.selectedIndex = 0
        _ = chatView.navigationController?.popToRootViewController(animated: true)
    })
    
    chatView.hidesBottomBarWhenPushed = true
    openViewController(chatView)
}

public func createGroupChat(_ users: [String], title: String) {
    let chatView = Qiscus.createChatView(withUsers: users, title: title)
    
    chatView.titleAction = {
        let targetVC                        = DetailChatVC()
        //targetVC.id                         = -1
        targetVC.hidesBottomBarWhenPushed   = true
        chatView.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    chatView.setBackButton(withAction: {
        chatView.tabBarController?.selectedIndex = 0
        _ = chatView.navigationController?.popToRootViewController(animated: true)
    })
    
    chatView.hidesBottomBarWhenPushed = true
    openViewController(chatView)
}
