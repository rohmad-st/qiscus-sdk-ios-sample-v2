//
//  NewGroupInfoVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/17/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class NewGroupInfoVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var viewModel = GroupInfoViewModel()
    
    var selectedContacts = [Contact]() {
        didSet {
            self.viewModel.itemSelecteds.append(contentsOf: selectedContacts)
        }
    }
    var groupName: String? {
        didSet {
            if groupName != nil {
                self.isEnableButton(isEnable())
            }
        }
    }
    
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

extension NewGroupInfoVC {
    func setupUI() -> Void {
        self.title = "Add Group Info"
        
        viewModel.delegate = self
        viewModel.loadData()
        
        // MARK: - Register table & cell
        tableView.delegate              = self.viewModel
        tableView.dataSource            = self.viewModel
        tableView.estimatedRowHeight    = 100
        tableView.rowHeight             = UITableViewAutomaticDimension
        tableView.register(GroupInfoCell.nib,
                           forCellReuseIdentifier: GroupInfoCell.identifier)
        tableView.register(SetGroupPhotoCell.nib,
                           forCellReuseIdentifier: SetGroupPhotoCell.identifier)
        tableView.register(SelectParticipantCell.nib,
                           forCellReuseIdentifier: SelectParticipantCell.identifier)
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done,
                                          target: self,
                                          action: #selector(done(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.isEnableButton(false)
    }
    
    @objc func done(_ sender: Any) {
        guard let title = self.groupName else { return }
        let emails = self.selectedContacts.flatMap({ $0.email })
        
        print("create group :\(title) with participants: \(emails)")
        createGroupChat(emails, title: title)
    }
    
    func isEnable() -> Bool {
        guard let name = self.groupName else { return false }
        return (name.count >= 3 && self.selectedContacts.count >= 2)
    }
    
    func isEnableButton(_ enable: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = enable
    }
}

extension NewGroupInfoVC: GroupInfoViewDelegate {
    func groupNameDidChanged(_ name: String) {
        groupName = name
    }
    
    func participantDidChanged(_ participants: [Contact]) {
        self.isEnableButton(isEnable())
        
        viewModel.loadData()
    }
    
    func participantDidUpdated() {
        tableView.reloadData()
    }
}
