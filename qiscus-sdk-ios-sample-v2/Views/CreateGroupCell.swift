//
//  CreateGroupCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/10/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class CreateGroupCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: ChatNewViewModelItem? {
        didSet {
            guard (item as? ChatNewViewModelCreateGroupItem) != nil else {
                return
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
        
        // Initialization code
        iconImageView.tintColor(.baseIconColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
