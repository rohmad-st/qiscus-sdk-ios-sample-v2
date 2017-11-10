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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContactVC {
    func setupUI() {
        self.title = "Contact"
        
        tableView.delegate = self
        tableView.dataSource = self.viewModel
        tableView.register(ContactCell.nib,
                           forCellReuseIdentifier: ContactCell.identifier)
    }
    
    func showDialog() -> Void {
        let alertController = UIAlertController(title: "Action Sheet",
                                                message: "What would you like to do?",
                                                preferredStyle: .actionSheet)
        
        let chatButton = UIAlertAction(title: "Chat",
                                       style: .default,
                                       handler: { (action) -> Void in
                                        print("Chat button tapped")
        })
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: { (action) -> Void in
                                            print("Cancel button tapped")
        })
        
        alertController.addAction(chatButton)
        alertController.addAction(cancelButton)
        alertController.preferredAction = chatButton
        
        self.navigationController?.present(alertController,
                                           animated: true,
                                           completion: nil)
    }

}

extension ContactVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDialog()
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
