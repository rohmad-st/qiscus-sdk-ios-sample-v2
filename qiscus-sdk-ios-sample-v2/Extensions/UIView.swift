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
    
    // MARK: - Empty background state
    class func backgroundView(_ image: UIImage, title top: String, description bottom: String, titleButton button: String, iconButton icon: UIImage, target: Any, action: Selector, btnWidth: CGFloat? = 0) -> UIView {
        let height: CGFloat         = CGFloat.screenHeight
        let width: CGFloat          = (CGFloat.screenWidth - 30)
        let x: CGFloat              = 15
        let y: CGFloat              = (height/2)
        let imageSize: CGFloat      = ((width / 3.5) + 30)
        let buttonWidth: CGFloat    = (btnWidth == 0) ? (imageSize * 2) : btnWidth!
        let spacing: CGFloat        = 20
        let fontSize: CGFloat       = 15
        
        let centerPosition: CGFloat         = (CGFloat.screenWidth / 2) - (imageSize / 2)
        let centerHorizontal: CGFloat       = (CGFloat.screenHeight / 3)
        let centerHorizontalImage: CGFloat  = (centerHorizontal - imageSize)
        
        let view = UIView(frame:CGRect(x: x,
                                       y: y,
                                       width: width,
                                       height: height))
        
        // add image
        let imageView = UIImageView(frame: CGRect(x: centerPosition,
                                                  y: centerHorizontalImage,
                                                  width: imageSize,
                                                  height: imageSize))
        imageView.image = image
        
        // add title
        let xPosition: CGFloat = (imageView.bounds.origin.x + x)
        let title = UILabel(frame: CGRect(x: xPosition,
                                          y: centerHorizontal + 30,
                                          width: width,
                                          height: 20))
        title.textAlignment     = NSTextAlignment.center
        title.textColor         = UIColor.black
        title.font              = UIFont.boldSystemFont(ofSize: fontSize)
        title.text              = top
        
        // add description
        let description = UITextView(frame: CGRect(x: xPosition,
                                                   y: (title.frame.origin.y + spacing),
                                                   width: width,
                                                   height: 50))
        description.textAlignment     = NSTextAlignment.center
        description.textColor         = UIColor.black
        description.font              = UIFont.systemFont(ofSize: fontSize)
        description.text              = bottom
        description.isEditable        = false
        
        // add reload button
        let reloadButton = UIButton(frame: CGRect(x: ((CGFloat.screenWidth / 2) - (buttonWidth/2)),
                                                  y: (description.frame.maxY + 10),
                                                  width: buttonWidth,
                                                  height: 35))
        reloadButton.backgroundColor    = UIColor.baseButtonBgColor
        reloadButton.layer.cornerRadius = 10
        reloadButton.setTitle("  \(button)", for: .normal)
        reloadButton.setImage(icon, for: .normal)
        reloadButton.setTitleColor(UIColor.baseButtonTextColor, for: .normal)
        reloadButton.addTarget(target, action: action, for: .touchUpInside)
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        view.addSubview(imageView)
        view.addSubview(title)
        view.addSubview(description)
        view.addSubview(reloadButton)
        
        return view
    }
}
