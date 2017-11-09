//
//  DetailContactVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class DetailContactVC: UIViewController {

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

extension DetailContactVC {
    func setupUI() -> Void {
        self.title = "Detail Contact"
    }
}
