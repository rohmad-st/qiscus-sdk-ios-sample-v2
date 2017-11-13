//
//  NewGroupVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class NewGroupVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel: GroupNewViewModel?
    var selectedContacts = [Contact]() {
        didSet {
            let isEnable: Bool = (selectedContacts.count > 1)
            self.isEnableButton(isEnable)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = GroupNewViewModel(delegate: self)
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension NewGroupVC {
    func setupUI() -> Void {
        self.title = "Create Group"
        
        tableView.delegate = self.viewModel
        tableView.allowsMultipleSelection = true
        tableView.rowHeight = 65
        tableView.dataSource = self.viewModel
        tableView.register(ContactCell.nib,
                           forCellReuseIdentifier: ContactCell.identifier)
        
        // add button in navigation right
        let rightButton = UIBarButtonItem(barButtonSystemItem: .save,
                                          target: self,
                                          action: #selector(next(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.isEnableButton(false)
    }
 
    func isEnableButton(_ enable: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = enable
    }
    
    @objc func next(_ sender: Any) {
        let view = NewGroupNameVC()
        view.selectedContacts = self.selectedContacts
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension NewGroupVC: GroupNewViewDelegate {
    func itemsDidChanged(contacts: [Contact]) {
        self.selectedContacts.removeAll()
        self.selectedContacts.append(contentsOf: contacts)
        self.tableView.reloadData()
    }
}
