//
//  ChatVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import Qiscus

class ChatVC: UIViewController, UILoadingView {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel = ChatListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        
        self.viewModel.delegate = self
        self.viewModel.loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(roomListChange(_:)), name: QiscusNotification.ROOM_ORDER_MAY_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(roomListChange(_:)), name: QiscusNotification.ROOM_DELETED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(roomListChange(_:)), name: QiscusNotification.GOT_NEW_ROOM, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func roomListChange(_ sender: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.viewModel.loadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ChatVC {
    func setupUI() -> Void {
        self.title = "Room List"
        
        // MARK: - Register table & cell
        tableView.delegate              = self.viewModel
        tableView.dataSource            = self.viewModel
        tableView.rowHeight             = 76
        tableView.register(ChatCell.nib,
                           forCellReuseIdentifier: ChatCell.identifier)
        
        // add button in navigation right
        let rightButton = UIBarButtonItem(image: UIImage(named: "ic_new_chat"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(newChat(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.setBackIcon()
    }
    
    @objc func newChat(_ sender: Any) {
        let view = NewChatVC()
        
        view.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension ChatVC: ChatListViewDelegate {
    func showLoading(_ message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.showLoading(message)
        }
    }
    
    func didFailedUpdated(_ message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.showError(message: message)
        }
    }
    
    func didFinishUpdated() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.tableView.reloadData()
            self.dismissLoading()
        }
    }
}
