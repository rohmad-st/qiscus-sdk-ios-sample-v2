//
//  AppDelegate.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Qiscus

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var baseApp: BaseApplication?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setNavigationColor(.baseNavigateColor, .baseNavigateTextColor)
        self.setTabBarColor(.baseTabBarColor, .basetabBarActiveColor)
        
        // check user is already logged in?
        self.baseApp?.validateUser()
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // Preference.instance.clearAll()
        self.baseApp = BaseApplication(delegate: self)
        return true
    }
    
}

extension AppDelegate {
    func getBaseApp() -> BaseApplication {
        return self.baseApp!
    }
    
    // MARK: - Set navigation color
    func setNavigationColor(_ barTintColor: UIColor, _ tintColor: UIColor) {
        let navigationBar = UINavigationBar.appearance()
        
        UIApplication.shared.statusBarStyle = .lightContent
        navigationBar.barStyle = .blackOpaque
        navigationBar.barTintColor = barTintColor
        navigationBar.tintColor = tintColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: tintColor]
        navigationBar.isTranslucent = false
    }
    
    // MARK: - Setup tab bar
    func setupTabBar() {
        // unactivated IQKeyboardManager
        self.enableIQKeyboard(false)
        
        let tabBarController = UITabBarController()
        
        // Set up the first View Controller
        let nav1 = UINavigationController()
        let vc1 = ChatVC()
        vc1.tabBarItem.title = "Room List"
        vc1.tabBarItem.image = UIImage(named: "ic_room_list")
        nav1.setViewControllers([vc1], animated: true)
        
        // Set up chats controller
        let nav2 = UINavigationController()
        let vc2 = ContactVC()
        vc2.tabBarItem.title = "Contact"
        vc2.tabBarItem.image = UIImage(named: "ic_contact")
        nav2.setViewControllers([vc2], animated: true)
        
        // Set up the settings View Controller
        let nav3 = UINavigationController()
        let vc3 = SettingVC()
        vc3.tabBarItem.title = "Setting"
        vc3.tabBarItem.image = UIImage(named: "ic_settings")
        nav3.setViewControllers([vc3], animated: true)
        
        // Set up the Tab Bar Controller
        tabBarController.viewControllers = [nav1, nav2, nav3]
        
        // attribute tab bar
        tabBarController.selectedIndex = 0
        
        // Make the Tab Bar Controller the root view controller
        window                      = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController  = tabBarController
        window?.backgroundColor     = UIColor.white
        window?.makeKeyAndVisible()
    }
    
    func setTabBarColor(_ barTintColor: UIColor, _ tintColor: UIColor) {
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = barTintColor
        tabBar.tintColor = tintColor
    }
    
    func enableIQKeyboard(_ enable: Bool) -> Void {
        IQKeyboardManager.shared.enable = enable
        IQKeyboardManager.shared.enableAutoToolbar = enable
    }
}

extension AppDelegate: BaseAppDelegate {
    func alreadyLoggedIn() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.setupTabBar()
            
            // registering push notification after success connect qiscus sdk
            Qiscus.registerNotification()
        })
    }
    
    func needLoggedIn(_ message: String) {
        // activated IQKeyboardManager
        self.enableIQKeyboard(true)
        
        let targetVC                    = LoginVC()
        targetVC.withMessage            = message
        
        let navController               = UINavigationController()
        navController.viewControllers   = [targetVC]
        
        let root                            = navController
        self.window                         = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController     = root
        self.window!.backgroundColor        = UIColor.white
        self.window!.makeKeyAndVisible()
    }
}


// MARK: - Push Notification Configuration
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("AppDelegate. didRegisterForRemoteNotificationsWithDeviceToken: \(deviceToken)")
        Qiscus.didRegisterUserNotification(withToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("AppDelegate. didReceive: \(notification)")
        Qiscus.didReceiveNotification(notification: notification)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("AppDelegate. didReceiveRemoteNotification: \(userInfo)")
        // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CHAT_RECEIVE_NOTIFICATION"),
        //                                 object: userInfo)
        Qiscus.didReceive(RemoteNotification: userInfo)
    }
}
