//
//  ChatManager.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit
//import Qiscus

class ChatManager {
    class func initChat() -> Void {
        //        Qiscus.setup(withAppId: Helper.APP_ID,
        //                     userEmail: Helper.USER_EMAIL,
        //                     userKey: Helper.USER_PASSWORD,
        //                     username: Helper.USER_USERNAME,
        //                     avatarURL: Helper.USER_AVATAR_URL,
        //                     delegate: self
        //        )
        
        print("Init chat with APP_ID", Helper.APP_ID)
    }
}

public func openViewController(_ viewController: UIViewController) -> Void {
    let app = UIApplication.shared.delegate as! AppDelegate
    if let rootView = app.window?.rootViewController as? UINavigationController {
        rootView.pushViewController(viewController, animated: true)
        
    } else if let rootView = app.window?.rootViewController as? UITabBarController {
        if let navigation = rootView.selectedViewController as? UINavigationController {
            navigation.pushViewController(viewController, animated: true)
        }
    }
}
