//
//  MainVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import Qiscus

class MainVC: UIViewController, UILoadingView {

    @IBOutlet weak var appIdField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        // set default fields
        self.appIdField.text        = Helper.APP_ID
        self.emailField.text        = Helper.USER_EMAIL
        self.passwordField.text     = Helper.USER_PASSWORD
        self.usernameField.text     = Helper.USER_USERNAME
        
        // add done button in navigation right
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(login(_:)))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Qiscus SDK iOS V2"
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MainVC {
    @objc func login(_ sender: Any) {
        self.showWaiting(message: "Logged in...")
        guard let appId = self.appIdField.text else { return }
        guard let email = self.emailField.text else { return }
        guard let password = self.passwordField.text else { return }
        guard let username = self.usernameField.text else { return }

        Qiscus.setup(withAppId: appId,
                     userEmail: email,
                     userKey: password,
                     username: username,
                     delegate: self,
                     secureURl: true)
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
}

extension MainVC: QiscusConfigDelegate {
    func qiscusConnected() {
        // custom theme sdk after success connected to qiscus sdk
        self.customTheme()
        
        // start setup tab bar
        let app = UIApplication.shared.delegate as! AppDelegate
        app.setupTabBar()
    }
    
    func qiscusFailToConnect(_ withMessage: String) {
        self.showError(message: "Failed connect. Error: \(withMessage)")
    }
}
