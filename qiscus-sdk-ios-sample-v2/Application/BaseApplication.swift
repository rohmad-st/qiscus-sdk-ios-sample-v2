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
    func needLoggedIn()
}

class BaseApplication: QiscusConfigDelegate {
    fileprivate var delegate: BaseAppDelegate?
    
    init(delegate: BaseAppDelegate) {
        self.delegate = delegate
    }
    
    func validateUser() {
        let pref = Preference.instance.getLocal()
        let appId = pref.appId!
        let username = pref.username!
        let email = pref.email!
        let pass = pref.password!
        
        if !(email.isEmpty) {
            self.delegate?.alreadyLoggedIn()

            Qiscus.setup(withAppId: appId,
                         userEmail: email,
                         userKey: pass,
                         username: username,
                         delegate: self,
                         secureURl: true)

        } else {
            self.delegate?.needLoggedIn()
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
        // Qiscus.iCloudUploadActive(true)
    }
    
    func qiscusConnected() {
        // custom theme sdk after success connected to qiscus sdk
        self.customTheme()
    }
    
    func qiscusFailToConnect(_ withMessage: String) {
        print("Failed connect. Error: \(withMessage)")
    }
}
