//
//  DetailGroupVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/18/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class DetailGroupVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var id: Int?
    fileprivate var viewModel = GroupDetailViewModel()
    
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


extension DetailGroupVC {
    func setupUI() -> Void {
        self.title = "Group Info"
        
        // MARK: - Register table & cell
        guard let roomId = self.id else { return }
        
        viewModel.id                    = roomId
        tableView.backgroundColor       = UIColor.baseBgTableView
        tableView.delegate              = self.viewModel
        tableView.dataSource            = self.viewModel
        tableView.register(GroupPictureCell.nib,
                           forCellReuseIdentifier: GroupPictureCell.identifier)
        tableView.register(ParticipantCell.nib,
                           forCellReuseIdentifier: ParticipantCell.identifier)
        
        self.setBackIcon()
    }
}
