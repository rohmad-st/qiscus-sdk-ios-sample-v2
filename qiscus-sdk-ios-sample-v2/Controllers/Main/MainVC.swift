//
//  MainVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self,
                                                                 action: #selector(login(_:)))
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
        print("MainVC login did tap...")
    }
}
