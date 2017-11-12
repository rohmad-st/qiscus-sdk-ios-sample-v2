//
//  MainVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UILoadingView {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        // set default fields
        self.emailField.text        = Helper.USER_EMAIL
        self.passwordField.text     = Helper.USER_PASSWORD
        
        // add done button in navigation right
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(login(_:)))
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Login"
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
        guard let email = self.emailField.text else { return }
        guard let password = self.passwordField.text else { return }
        
        // save data in local storage for temporary
        let data = PrefData(appId: Helper.APP_ID,
                            email: email,
                            password: password,
                            username: Helper.USER_USERNAME)
        Preference.instance.setLocal(preference: data!)
        
        // start authenticate user
        let app = UIApplication.shared.delegate as! AppDelegate
        app.getBaseApp().validateUser()
    }
    
}
