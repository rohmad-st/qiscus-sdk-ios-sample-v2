//
//  LeaveCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class LeaveCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: ChatDetailViewModelItem? {
        didSet {
            guard (item as? ChatDetailViewModelLeaveItem) != nil else {
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
        let color: UIColor = UIColor.dangerColor
        self.titleLabel.textColor = color
        self.iconImageView.tintColor(color)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
