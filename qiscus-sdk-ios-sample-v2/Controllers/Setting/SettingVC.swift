//
//  SettingVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonDidTouchUpInside(_ sender: UIButton) {
        Preference.instance.clearAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            // start authenticate user
            let app = UIApplication.shared.delegate as! AppDelegate
            app.getBaseApp().validateUser()
        })
    }
}

extension SettingVC {
    func setupUI() -> Void {
        self.title = "Setting"
    }
}
