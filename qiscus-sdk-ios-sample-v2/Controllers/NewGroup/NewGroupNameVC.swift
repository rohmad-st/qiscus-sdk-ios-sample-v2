//
//  NewGroupNameVC.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class NewGroupNameVC: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var groupNameField: UITextField!
    @IBOutlet weak var participantsCountLabel: UILabel!
    
    var selectedContacts = [Contact]() {
        didSet {
            print("selected contact in NewGroupNameVC is: \(selectedContacts.flatMap({ $0.email }))")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.hideKeyboardWhenTappedAround()
        self.groupNameField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func groupNameDidChanged(_ sender: UITextField) {
        guard let groupName = sender.text else { return }
        let isEnable: Bool = (groupName.count >= 3)
        self.isEnableButton(isEnable)
    }
}

extension NewGroupNameVC {
    func setupUI() -> Void {
        self.title = "Create Group"
        
        self.participantsCountLabel.text = "\(self.selectedContacts.count) Participants Selected"
        
        if let photoImage = cameraButton.currentBackgroundImage?.withRenderingMode(.alwaysTemplate) {
            cameraButton.setBackgroundImage(photoImage, for: .normal)
            cameraButton.tintColor = UIColor.baseButtonBgColor
        }
        
        avatarImageView.layer.cornerRadius = (avatarImageView.frame.height / 2)
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.backgroundColor = UIColor.lightGray
        
        // add button in navigation right
        let rightButton = UIBarButtonItem(barButtonSystemItem: .done,
                                          target: self,
                                          action: #selector(saveGroup(_:)))
        self.navigationItem.rightBarButtonItem = rightButton
        self.isEnableButton(false)
    }
    
    @objc func saveGroup(_ sender: Any) {
        guard let title = self.groupNameField.text else { return }
        let alertController = UIAlertController(title: title,
                                                message: "Are you sure want to create this group with \(self.selectedContacts.count) participants?",
                                                preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: { (action) -> Void in
                                            self.createGroup()
        })
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: { (action) -> Void in
                                            print("Cancel button tapped")
        })
        
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        alertController.preferredAction = okButton
        
        present(alertController, animated: true, completion: nil)
    }
    
    func isEnableButton(_ enable: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = enable
    }
    
    func createGroup() {
        guard let title = self.groupNameField.text else { return }
        let emails = selectedContacts.flatMap({ $0.email })
        
        createGroupChat(emails, title: title)
    }
}
