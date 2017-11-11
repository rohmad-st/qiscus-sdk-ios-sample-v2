//
//  DetailChatVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class DetailChatVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel = ChatDetailViewModel()
    var id: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel.id = self.id
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailChatVC {
    func setupUI() -> Void {
        self.title = "Detail Chat"
        
        tableView.delegate              = self.viewModel
        tableView.dataSource            = self.viewModel
        tableView.estimatedRowHeight    = 100
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.register(NamePictureCell.nib,
                           forCellReuseIdentifier: NamePictureCell.identifier)
        tableView.register(ParticipantCell.nib,
                           forCellReuseIdentifier: ParticipantCell.identifier)
        tableView.register(LeaveCell.nib,
                           forCellReuseIdentifier: LeaveCell.identifier)
        
    }
}
