//
//  DetailContactVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class DetailContactVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel = ContactDetailViewModel()
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel.email = self.email
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DetailContactVC {
    func setupUI() -> Void {
        self.title = "Contact Detail"
        
        tableView.backgroundColor       = UIColor.baseBgTableView
        tableView.delegate              = self.viewModel
        tableView.dataSource            = self.viewModel
        tableView.estimatedRowHeight    = 100
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.register(ContactPictureCell.nib,
                           forCellReuseIdentifier: ContactPictureCell.identifier)
        tableView.register(ActionCell.nib,
                           forCellReuseIdentifier: ActionCell.identifier)
    }
}
