//
//  LeaveCell.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

class LeaveCell: UITableViewCell {

    @IBOutlet weak var leaveButton: UIButton!
    
    var item: ChatDetailViewModelItem? {
        didSet {
            guard let item = item as? ChatDetailViewModelLeaveItem else {
                return
            }
            
            leaveButton.addTarget(item.target,
                                  action: item.action,
                                  for: .touchUpInside)
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
        leaveButton.setImage(UIImage(named: "ic_exit"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
