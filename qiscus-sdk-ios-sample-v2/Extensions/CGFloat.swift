//
//  CGFloat.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/12/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    static var screenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    static var screenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    
    func flexibleIphoneFont() -> CGFloat {
        switch (CGFloat.screenHeight) {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            return self * 0.7
        case 568.0: //iphone 5, 5s => 4 inch
            return self * 0.8
        case 667.0: //iphone 6, 6s => 4.7 inch
            return self * 0.9
        case 736.0: //iphone 6s+ 6+ => 5.5 inch
            return self
        default:
            return self
        }
    }
}
