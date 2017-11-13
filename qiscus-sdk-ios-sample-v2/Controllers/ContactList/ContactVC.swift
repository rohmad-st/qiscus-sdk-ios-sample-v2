//
//  ContactVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel = ContactListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        
        self.viewModel.delegate = self
        self.viewModel.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContactVC {
    func setupUI() {
        self.title = "Contact"
        
        tableView.delegate = self.viewModel
        tableView.dataSource = self.viewModel
        tableView.register(ContactCell.nib,
                           forCellReuseIdentifier: ContactCell.identifier)
    }
}

extension ContactVC: ContactListViewDelegate {
    func didFinishUpdated() {
        tableView.reloadData()
    }
}
