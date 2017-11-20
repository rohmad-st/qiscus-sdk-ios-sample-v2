//
//  ParticipantCollCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class ParticipantCollCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    
    var item: Contact? {
        didSet {
            guard let item = item else {
                return
            }
            
            nameLabel.text = item.name
            avatarImageView.loadAsync(item.avatarURL!,
                                      placeholderImage: UIImage(named: "ic_default_avatar"),
                                      header: Helper.headers)
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        avatarImageView.layer.cornerRadius  = (avatarImageView.frame.height / 2)
        avatarImageView?.clipsToBounds      = true
        avatarImageView?.contentMode        = .scaleAspectFit
        avatarImageView?.backgroundColor    = UIColor.lightGray
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView?.image = nil
    }
}
