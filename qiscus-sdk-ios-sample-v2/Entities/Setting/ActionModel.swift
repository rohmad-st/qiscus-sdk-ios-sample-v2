//
//  ActionModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/18/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

enum ActionType {
    case chat
    case logout
}

class Action {
    var title: String?
    var icon: UIImage?
    var type: ActionType?
    var enable: Bool?
    
    init(title: String, icon: UIImage, type: ActionType, enable: Bool) {
        self.title = title
        self.icon = icon
        self.type = type
        self.enable = enable
    }
}
