//
//  ChatListVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class ChatListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel = ChatListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        
        self.viewModel.delegate = self
        self.viewModel.loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotNewComment(_:)),
                                               name: NSNotification.Name(rawValue: "CHAT_FINISH_LOAD_ROOM"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gotNewComment(_:)),
                                               name: NSNotification.Name(rawValue: "CHAT_NEW_COMMENT"),
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func gotNewComment(_ sender: Notification) {
        self.viewModel.loadData()
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
        let rightButton = UIBarButtonItem(image: UIImage(named: "ic_new_chat"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(newChat(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func newChat(_ sender: Any) {
        let view = NewChatVC()
        
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension ChatListVC: ChatListViewDelegate {
    func didFinishUpdated() {
        self.tableView.reloadData()
    }
}
