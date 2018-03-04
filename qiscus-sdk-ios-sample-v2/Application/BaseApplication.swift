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
    }
    
    func validateUser() {
        let pref = Preference.instance.getLocal()
        guard let appId = pref.appId else { return }
        guard let username = pref.username else { return }
        guard let email = pref.email else { return }
        guard let pass = pref.password else { return }
        guard let avatarURL = pref.avatarURL else { return }
        
        if !(email.isEmpty) {
            Qiscus.setup(withAppId: appId,
                         userEmail: email,
                         userKey: pass,
                         username: username,
                         avatarURL: avatarURL,
                         delegate: self,
                         secureURl: true)

        } else {
            // call clear func for cleared data of Qiscus SDK
            // so when we switch user for login, we get truly new data
            if Qiscus.isLoggedIn { Qiscus.clear() }
            
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
        
        // activate feature camera, galery, iCloud, contact, location
        Qiscus.shared.cameraUpload = true
        Qiscus.shared.galeryUpload = true
        Qiscus.shared.iCloudUpload = true
        Qiscus.shared.contactShare = true
        Qiscus.shared.locationShare = true
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
    
    func qiscus(didRegisterPushNotification success: Bool, deviceToken: String, error: String?) {
        guard let error = error else { return }
        print("AppDelegate callback didRegisterPushNotification error: \(error)")
    }
    
    func qiscus(didUnregisterPushNotification success: Bool, error: String?) {
        guard let error = error else { return }
        print("AppDelegate callback didUnregisterPushNotification error: \(error)")
    }
    
    func qiscus(didTapLocalNotification comment: QComment, userInfo: [AnyHashable : Any]?) {
        print("AppDelegate callback didTapLocalNotification comment: \(comment.roomName) - \(comment.senderEmail)")
    }
}
