//
//  SelectParticipantCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/17/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class SelectParticipantCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    var item: Contact? {
        didSet {
            guard let item = item else {
                return
            }
            
            avatarImageView.loadAsync(item.avatarURL!,
                                      placeholderImage: UIImage(named: "ic_default_avatar"),
                                      header: Helper.headers)
            nameLabel.text = item.name
        }
    }
    
    var isChecked: Bool? {
        didSet {
            //self.checked()
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let imageView: UIImageView = UIImageView(frame: CGRect(x: 280.0,
//                                                               y: 26.0,
//                                                               width: 24.0,
//                                                               height: 24.0))
//        imageView.image = UIImage(named: "ic_check")?.imageWithInsets(insetDimen: 7)
//        imageView.layer.cornerRadius    = (imageView.frame.height / 2)
//        imageView.contentMode           = .scaleAspectFit
//        imageView.clipsToBounds         = true
        
//        print("check imageview position x:\(checkImageView.frame.origin.x) y:\(checkImageView.frame.origin.y)")
//        checkImageView.image                = checkImageView.image?.imageWithInsets(insetDimen: 6.0)
//        checkImageView.layer.cornerRadius   = (checkImageView.frame.height / 2)
//        checkImageView.contentMode          = .scaleAspectFit
//        checkImageView?.clipsToBounds       = true
        //checkImageView.isHidden             = true
        
        avatarImageView.layer.cornerRadius  = (avatarImageView.frame.height / 2)
        avatarImageView?.clipsToBounds      = true
        avatarImageView?.contentMode        = .scaleAspectFit
        avatarImageView?.backgroundColor    = UIColor.lightGray
        
//        accessoryView = imageView
        //self.checked()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView?.image = nil
    }
    
    private func checked() {
        if let isChecked = self.isChecked {
            let background: UIColor = (isChecked) ? UIColor.baseBgSelectedIcon : UIColor.lightGray
            avatarImageView?.backgroundColor = background
        }
    }
}
