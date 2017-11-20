//
//  Utilities.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit

public func dataFromURL(of url: String) -> Data? {
    if let url = URL(string: url) {
        return try? Data(contentsOf: url)
    }
    
    return nil
}

public func popViewController(_ animated: Bool = true) -> Void {
    let app = UIApplication.shared.delegate as! AppDelegate
    if let rootView = app.window?.rootViewController as? UINavigationController {
        rootView.popViewController(animated: animated)
        
    } else if let rootView = app.window?.rootViewController as? UITabBarController {
        if let navigation = rootView.selectedViewController as? UINavigationController {
            navigation.popViewController(animated: animated)
        }
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

public func presentViewController(_ viewController: UIViewController) -> Void {
    let app = UIApplication.shared.delegate as! AppDelegate
    if let rootView = app.window?.rootViewController as? UINavigationController {
        rootView.present(viewController, animated: true, completion: nil)
        
    } else if let rootView = app.window?.rootViewController as? UITabBarController {
        if let navigation = rootView.selectedViewController as? UINavigationController {
            navigation.present(viewController, animated: true, completion: nil)
        }
    }
}
