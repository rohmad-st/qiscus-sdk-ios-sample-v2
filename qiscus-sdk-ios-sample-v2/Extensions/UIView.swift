//
//  UIView.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/15/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

extension UIView {
    class func headerInTableView(_ title: String) -> UIView {
        let view            = UIView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: 20,
                                                   height: 50))
        let label           = UILabel(frame: CGRect(x: 15,
                                                    y: 25,
                                                    width: CGFloat.screenWidth,
                                                    height: 20))
        label.text          = title
        label.textAlignment = .left
        label.textColor     = UIColor.baseFontDark
        label.font          = UIFont.systemFont(ofSize: 15)
        
        view.addSubview(label)
        view.backgroundColor = UIColor.baseBgHeader
        
        return view
    }
    
}
