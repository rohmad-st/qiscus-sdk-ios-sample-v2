//
//  AppDelegate.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BaseAppDelegate {

    var window: UIWindow?
    var baseApp: BaseApplication?
    let tabBarController = UITabBarController()

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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
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
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: tintColor]
        navigationBar.isTranslucent = false
    }
    
    // MARK: - Setup tab bar
    func setupTabBar() {
        // Set up the first View Controller
        let nav1 = UINavigationController()
        let vc1 = ChatListVC()
        vc1.tabBarItem.title = "Chat"
        vc1.tabBarItem.image = UIImage(named: "ic_forum")
        nav1.setViewControllers([vc1], animated: true)

        // Set up chats controller
        let nav2 = UINavigationController()
        let vc2 = ContactVC()
        vc2.tabBarItem.title = "Contact"
        vc2.tabBarItem.image = UIImage(named: "ic_person")
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
    
    func alreadyLoggedIn() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.setupTabBar()
        })
    }
    
    func needLoggedIn() {
        let navController               = UINavigationController()
        navController.viewControllers   = [MainVC()]
        
        let root                            = navController
        self.window                         = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController     = root
        self.window!.backgroundColor        = UIColor.white
        self.window!.makeKeyAndVisible()
    }
    
    func setTabBarColor(_ barTintColor: UIColor, _ tintColor: UIColor) {
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = barTintColor
        tabBar.tintColor = tintColor
    }
}
