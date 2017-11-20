//
//  GroupPictureCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/18/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class GroupPictureCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: GroupDetailViewModelItem? {
        didSet {
            guard let item = item as? GroupDetailViewModelInfoItem else {
                return
            }
            
            avatarImageView.loadAsync(item.avatarURL,
                                      placeholderImage: UIImage(named: "ic_default_group"),
                                      header: Helper.headers)
            nameLabel.text = item.name
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
