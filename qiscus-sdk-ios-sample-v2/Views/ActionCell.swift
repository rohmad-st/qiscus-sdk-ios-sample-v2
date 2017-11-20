//
//  ActionCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/15/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: Action? {
        didSet {
            guard let item = item else {
                return
            }
            
            titleLabel.text = item.title
            iconImageView.image = item.icon
            
            self.customCell(item)
        }
    }
    
    private func customCell(_ action: Action?) {
        guard let type = action?.type else { return }
        
        switch type {
        case .chat:
            iconImageView.tintColor(.baseIconColor)
        case .logout:
            titleLabel.textColor = UIColor.baseLogout
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
        
        iconImageView?.clipsToBounds    = true
        iconImageView?.contentMode      = .scaleAspectFit
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView?.image = nil
    }
}
