//
//  BaseApplication.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Qiscus

protocol BaseAppDelegate {
    func alreadyLoggedIn()
    func needLoggedIn(_ message: String)
}

class BaseApplication {
    fileprivate var delegate: BaseAppDelegate?
    
    init(delegate: BaseAppDelegate) {
        self.delegate = delegate
        
        QiscusCommentClient.sharedInstance.roomDelegate = self
    }
    
    func validateUser() {
        let pref = Preference.instance.getLocal()
        guard let appId = pref.appId else { return }
        guard let username = pref.username else { return }
        guard let email = pref.email else { return }
        guard let pass = pref.password else { return }
        
        if !(email.isEmpty) {
            Qiscus.setup(withAppId: appId,
                         userEmail: email,
                         userKey: pass,
                         username: username,
                         delegate: self,
                         secureURl: true)

        } else {
            // call clear func for cleared data of Qiscus SDK
            // so when we switch user for login, we get truly new data
            Qiscus.clear()
            
            self.delegate?.needLoggedIn("")
        }
    }
    
    func customTheme() -> Void {
        let qiscusColor = Qiscus.style.color
        Qiscus.style.color.welcomeIconColor = UIColor.chatWelcomeIconColor
        qiscusColor.leftBaloonColor = UIColor.chatLeftBaloonColor
        qiscusColor.leftBaloonTextColor = UIColor.chatLeftTextColor
        qiscusColor.leftBaloonLinkColor = UIColor.chatLeftBaloonLinkColor
        qiscusColor.rightBaloonColor = UIColor.chatRightBaloonColor
        qiscusColor.rightBaloonTextColor = UIColor.chatRightTextColor
        Qiscus.setNavigationColor(UIColor.baseNavigateColor, tintColor: UIColor.baseNavigateTextColor)
        
        // activate qiscus iCloud
        Qiscus.iCloudUploadActive(true)
    }
}

extension BaseApplication: QiscusConfigDelegate {
    func qiscusConnected() {
        // custom theme sdk after success connected to qiscus sdk
        self.delegate?.alreadyLoggedIn()
        self.customTheme()
    }
    
    func qiscusFailToConnect(_ withMessage: String) {
        print("Failed connect. Error: \(withMessage)")
        self.delegate?.needLoggedIn(withMessage)
    }
}

extension BaseApplication: QiscusRoomDelegate {
    func gotNewComment(_ comments: QComment) {
        print("Got new comment: \(comments.text): \(comments)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHAT_NEW_COMMENT"),
                                        object: comments)
    }
    
    func didFinishLoadRoom(onRoom room: QRoom) {
        print("Already finish load room \(room.id): \(room)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHAT_FINISH_LOAD_ROOM"),
                                        object: room)
    }
    
    func didFailLoadRoom(withError error: String) {
        print("Failed load room. Error: \(error)")
    }
    
    func didFinishUpdateRoom(onRoom room: QRoom) {
        print("Finish update room: \(room.name)")
    }
    
    func didFailUpdateRoom(withError error: String) {
        print("Failed update room. Error: \(error)")
    }
}
