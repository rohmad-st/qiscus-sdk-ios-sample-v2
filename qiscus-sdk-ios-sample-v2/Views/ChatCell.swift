//
//  ChatCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import BadgeSwift
import Qiscus

class ChatCell: QRoomListCell {
    
    @IBOutlet weak var chatNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var badgeLabel: BadgeSwift!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var arrowRightImageView: UIImageView!
    
    static var nib: UINib {
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
    override func setupUI() {
        guard let item = room else { return }
        let imageDefault = (item.type == .group) ? UIImage(named: "ic_default_group") : UIImage(named: "ic_default_avatar")
        avatarImageView.loadAsync(item.avatarURL,
                                  placeholderImage: imageDefault,
                                  header: Helper.headers)
        chatNameLabel.text      = item.name
        
        
        if let lastMessage = room?.lastComment {
            lastMessageLabel.text   = lastMessage.text
            timestampLabel.text     = lastMessage.date.timestampFormat(of: lastMessage.time)
        }
        
        badgeLabel.text     = String(item.unreadCount)
        badgeLabel.isHidden = (item.unreadCount == 0)
    }
    
    override func roomNameChange() {
        chatNameLabel.text = room!.name
    }
    
    override func roomAvatarChange() {
        let imageDefault = (room!.type == .group) ? UIImage(named: "ic_default_group") : UIImage(named: "ic_default_avatar")
        avatarImageView.loadAsync(room!.avatarURL,
                                  placeholderImage: imageDefault,
                                  header: Helper.headers)
    }
    
    override func roomParticipantChange() {}
    
    override func roomLastCommentChange() {
        if let lastMessage = room?.lastComment {
            lastMessageLabel.text   = lastMessage.text
            timestampLabel.text     = lastMessage.time
        }
    }
    
    override func roomUnreadCountChange() {
        if let r = room {
            badgeLabel.text     = String(r.unreadCount)
            badgeLabel.isHidden = (r.unreadCount == 0)
        }
    }
    
    override func roomDataChange() {}
}

