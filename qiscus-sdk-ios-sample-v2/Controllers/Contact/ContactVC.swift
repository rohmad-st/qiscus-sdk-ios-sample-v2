//
//  ContactVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class ContactVC: UIViewController, UILoadingView {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel = ContactListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        
        self.viewModel.delegate = self
        self.viewModel.loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(finishLoadRoom(_:)),
                                               name: NSNotification.Name(rawValue: "CHAT_FINISH_LOAD_ROOM"),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func finishLoadRoom(_ sender: Notification) {
        self.loadData()
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
        
        // add button in navigation right
        let rightButton = UIBarButtonItem(image: UIImage(named: "ic_refresh"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(refreshData(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.isEnableButton(false)
        self.setBackIcon()
    }
    
    @objc func refreshData(_ sender: Any) {
        self.loadData()
    }
    
    func isEnableButton(_ enable: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = enable
        self.navigationItem.rightBarButtonItem?.tintColor = enable ? UIColor.white : UIColor.clear
    }
    
    func loadData() {
        self.viewModel.loadData()
    }
}

extension ContactVC: ContactListViewDelegate {
    func showLoading(_ message: String) {
        self.showWaiting(message: message)
    }
    
    func didFailedUpdated(_ message: String) {
        self.isEnableButton(true)
        self.showError(message: message)
    }
    
    func didFinishUpdated() {
        self.isEnableButton(false)
        self.dismissLoading()
        tableView.reloadData()
    }
    
}
