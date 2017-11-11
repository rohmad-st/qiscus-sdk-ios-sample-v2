//
//  ChatListVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import Qiscus
import Alamofire

class ChatListVC: UIViewController, UILoadingView {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel = ChatListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showWaiting(message: "Please wait...")
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ChatListVC {
    func setupUI() -> Void {
        self.title = "Chat"
        
        // MARK: - Register table & cell
        tableView.delegate              = self.viewModel
        tableView.dataSource            = self.viewModel
        tableView.rowHeight             = 65
        tableView.register(ChatCell.nib,
                           forCellReuseIdentifier: ChatCell.identifier)
        
        // add button in navigation right
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func add(_ sender: Any) {
        let view = NewChatVC()
        
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }
}
