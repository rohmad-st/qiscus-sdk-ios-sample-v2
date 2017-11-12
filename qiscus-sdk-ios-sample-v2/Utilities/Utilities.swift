//
//  Utilities.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit

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
