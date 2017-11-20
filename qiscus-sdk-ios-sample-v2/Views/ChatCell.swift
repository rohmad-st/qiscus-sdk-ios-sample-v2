//
//  ChatCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import BadgeSwift

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var badgeLabel: BadgeSwift!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var arrowRightImageView: UIImageView!
    
    var item: Chat? {
        didSet {
            guard let item = item else { return }
            let imageDefault = (item.isGroup!) ? UIImage(named: "ic_default_group") : UIImage(named: "ic_default_avatar")
            avatarImageView.loadAsync(item.avatarURL!,
                                      placeholderImage: imageDefault,
                                      header: Helper.headers)
            chatNameLabel.text      = item.name
            lastMessageLabel.text   = item.lastCommentText
            
            if let date = item.date {
                timestampLabel.text = date.timestampFormat(of: item.time)
            }
            if let unreadCount = item.unreadCount {
                badgeLabel.text     = String(unreadCount)
                badgeLabel.isHidden = (unreadCount == 0) ? true : false
            }
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
        
        arrowRightImageView.tintColor(.baseArrow)
        avatarImageView.layer.cornerRadius  = (avatarImageView.frame.height / 2)
        avatarImageView?.clipsToBounds      = true
        avatarImageView?.contentMode        = .scaleAspectFit
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
