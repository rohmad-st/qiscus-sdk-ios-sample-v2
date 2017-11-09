//
//  NewGroupNameVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class NewGroupNameVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension NewGroupNameVC {
    func setupUI() -> Void {
        self.title = "Create Group II"
    }
}
