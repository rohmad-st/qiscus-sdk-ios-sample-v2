//
//  UIImageView.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import Foundation
import Qiscus

var cache = NSCache<NSString,UIImage>()

public extension UIImage {
    public class func clearAllCache() {
        cache.removeAllObjects()
    }
    
    public class func clearCachedImageForURL(_ urlString:String) {
        cache.removeObject(forKey: urlString as NSString)
    }
    
    public class func resizeImage(_ image: UIImage, toFillOnImage: UIImage) -> UIImage {
        var scale:CGFloat = 1
        var newSize:CGSize = toFillOnImage.size
        
        if image.size.width > image.size.height {
            scale = image.size.width / image.size.height
            newSize.width = toFillOnImage.size.width
            newSize.height = toFillOnImage.size.height / scale
            
        } else {
            scale = image.size.height / image.size.width
            newSize.height = toFillOnImage.size.height
            newSize.width = toFillOnImage.size.width / scale
        }
        
        var scaleFactor = newSize.width / image.size.width
        if (image.size.height * scaleFactor) < toFillOnImage.size.height {
            scaleFactor = scaleFactor * (toFillOnImage.size.height / (image.size.height * scaleFactor))
        }
        if (image.size.width * scaleFactor) < toFillOnImage.size.width {
            scaleFactor = scaleFactor * (toFillOnImage.size.width / (image.size.width * scaleFactor))
        }
        
        UIGraphicsBeginImageContextWithOptions(toFillOnImage.size, false, scaleFactor)
        
        var xPos:CGFloat = 0
        if (image.size.width * scaleFactor) > toFillOnImage.size.width {
            xPos = ((image.size.width * scaleFactor) - toFillOnImage.size.width) / 2
        }
        var yPos:CGFloat = 0
        if (image.size.height * scale) > toFillOnImage.size.height{
            yPos = ((image.size.height * scaleFactor) - toFillOnImage.size.height) / 2
        }
        image.draw(in: CGRect(x: 0 - xPos,y: 0 - yPos, width: image.size.width * scaleFactor, height: image.size.height * scaleFactor))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIImageView {
    class func tintColors(_ color: UIColor, fields: [UIImageView]) -> Void {
        for field in fields {
            field.image = field.image!.withRenderingMode(.alwaysTemplate)
            field.tintColor = color
        }
    }
    
    func tintColor(_ color: UIColor) {
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
    
    class func checkImage(_ selected: Bool) -> UIImageView {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 280.0,
                                                               y: 26.0,
                                                               width: 24.0,
                                                               height: 24.0))
        imageView.image = UIImage(named: "ic_check")?.imageWithInsets(insetDimen: 7)
        imageView.layer.cornerRadius    = (imageView.frame.height / 2)
        imageView.contentMode           = .scaleAspectFit
        imageView.layer.borderWidth     = 1
        imageView.layer.borderColor     = (selected) ? UIColor.baseIconChecked.cgColor : UIColor.baseBorderIconUncheck.cgColor
        imageView.backgroundColor       = (selected) ? UIColor.baseIconChecked : UIColor.white
        imageView.clipsToBounds         = true
        imageView.layer.masksToBounds   = true
        
        return imageView
    }
    
    class func removeImage() -> UIImageView {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 280.0,
                                                               y: 26.0,
                                                               width: 24.0,
                                                               height: 24.0))
        imageView.image                 = UIImage(named: "ic_remove_participant_small")!
        imageView.layer.cornerRadius    = (imageView.frame.height / 2)
        imageView.contentMode           = .scaleAspectFit
        imageView.clipsToBounds         = true
        
        return imageView
    }
}
