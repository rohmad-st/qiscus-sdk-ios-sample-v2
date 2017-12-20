//
//  ChatManager.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

public class ChatManager: NSObject {
    static var shared = ChatManager()
    
    override private init() {}
    
    public class func chatWithRoomId(_ roomId: String, isGroup: Bool? = nil, contact: Contact? = nil) -> Void {
        let chatView = Qiscus.chatView(withRoomId: roomId)
        chatView.delegate = ChatManager.shared
        chatView.data = contact
        
        chatView.hidesBottomBarWhenPushed = true
        chatView.setBackTitle()
        openViewController(chatView)
    }
    
    /*
     * {email} can be contains of email or uniqueId
     * but in this case we always use value of email
     */
    public class func chatWithUser(_ contact: Contact) {
        guard let email = contact.email else { return }
        let chatView = Qiscus.chatView(withUsers: [email])
        chatView.delegate = ChatManager.shared
        chatView.data = contact
        
        
        chatView.hidesBottomBarWhenPushed = true
        chatView.setBackTitle()
        openViewController(chatView)
    }
    
    // {uniqueId} can be contains of: email/userId/phone
    public class func chatWithUniqueId(_ uniqueId: String) {
        let chatView = Qiscus.chatView(withUsers: [uniqueId])
        chatView.delegate = ChatManager.shared
        
        chatView.hidesBottomBarWhenPushed = true
        chatView.setBackTitle()
        openViewController(chatView)
    }
    
    public class func createGroupChat(_ users: [String], title: String, avatarURL: String = "") {
        Qiscus.newRoom(withUsers: users, roomName: title, avatarURL: avatarURL, onSuccess: { (room) in
            
            let chatView = Qiscus.chatView(withRoomId: room.id)
            chatView.delegate = ChatManager.shared
            
            chatView.hidesBottomBarWhenPushed = true
            chatView.setBackTitle()
            openViewController(chatView)
            
        }, onError: { (error) in
            print("new room failed: \(error)")
        })
    }
}

extension ChatManager: QiscusChatVCDelegate {
    public func chatVC(enableForwardAction viewController:QiscusChatVC)->Bool{
        return false
    }
    
    public func chatVC(enableInfoAction viewController:QiscusChatVC)->Bool{
        return false
    }
    
    public func chatVC(overrideBackAction viewController:QiscusChatVC)->Bool{
        return true
    }
    
    // MARK: - optional method
    public func chatVC(backAction viewController:QiscusChatVC, room:QRoom?, data:Any?){
        viewController.tabBarController?.selectedIndex = 0
        _ = viewController.navigationController?.popToRootViewController(animated: true)
    }
    
    public func chatVC(titleAction viewController:QiscusChatVC, room:QRoom?, data:Any?){
        if let r = room {
            if r.type == .group {
                let targetVC                        = DetailGroupVC()
                targetVC.id                         = r.id
                targetVC.hidesBottomBarWhenPushed   = true
                viewController.navigationController?.pushViewController(targetVC, animated: true)
                
            } else {
                guard let contact = data as? Contact else { return }
                
                let targetVC                        = DetailContactVC()
                targetVC.enableChatButton           = false
                targetVC.contact                    = contact
                
                targetVC.hidesBottomBarWhenPushed   = true
                viewController.navigationController?.pushViewController(targetVC, animated: true)
            }
        }
    }
    
}
