//
//  GroupInfoCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/17/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit


protocol GroupInfoCellViewDelegate {
    func fieldNameDidChanged(_ text: String?)
}

class GroupInfoCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!

    var delegate: GroupInfoCellViewDelegate?
    
    var item: GroupInfo? {
        didSet {
            guard let item = item else {
                return
            }
            
            nameField.text = item.name
            avatarImageView.image = item.avatarURL
        }
    }
    
    @IBAction func nameFieldDidChanged(_ sender: UITextField) {
        delegate?.fieldNameDidChanged(sender.text)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameField.setBottomBorder()
        avatarImageView.layer.cornerRadius  = (avatarImageView.frame.height / 2)
        avatarImageView?.clipsToBounds      = true
        avatarImageView?.contentMode        = .scaleAspectFill
        avatarImageView?.backgroundColor    = UIColor.lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView?.image = nil
    }
    
}
