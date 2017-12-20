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
    
    // MARK: - Methods is coming from QRoomListCell
    override func setupUI() {
        self.setAvatar()
        self.setName()
        self.setMessageTime()
        self.setUnreadCount()
    }
    
    override func roomNameChange() {
        self.setName()
    }
    
    override func roomAvatarChange() {
        self.setAvatar()
    }
    
    override func roomParticipantChange() {}
    
    override func roomLastCommentChange() {
        self.setMessageTime()
    }
    
    override func roomUnreadCountChange() {
        self.setUnreadCount()
    }
    
    override func roomDataChange() {}
    
    // MARK: - Custom methods from ChatCell class
    private func getLastMessage(of message: QComment?) -> String {
        guard let message = message else { return "" }
        
        switch message.type {
        case .text:
            return message.text
        default:
            return "Sending attachment"
        }
    }
    
    private func getTimestamp(of message: QComment?) -> String {
        guard let message = message else { return "" }
        return message.date.timestampFormat(of: message.time)
    }
    
    private func setName() -> Void {
        guard let r = room else { return }
        chatNameLabel.text = r.name
    }
    
    private func setMessageTime() -> Void {
        guard let message = room?.lastComment else { return }
        
        lastMessageLabel.text   = self.getLastMessage(of: message)
        timestampLabel.text     = self.getTimestamp(of: message)
    }
    
    private func setUnreadCount() -> Void {
        guard let r = room else { return }
        let count: Int = r.unreadCount
        
        badgeLabel.text     = String(count)
        badgeLabel.isHidden = (count == 0)
    }
    
    private func setAvatar() -> Void {
        guard let r = room else { return }
        let imageDefault = (r.type == .group) ? UIImage(named: "ic_default_group") : UIImage(named: "ic_default_avatar")
        
        avatarImageView.loadAsync(r.avatarURL,
                                  placeholderImage: imageDefault,
                                  header: Helper.headers)
    }
    
}

