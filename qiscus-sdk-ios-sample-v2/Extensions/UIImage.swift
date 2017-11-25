//
//  UIImage.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/17/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit

extension UIImage {
    func imageWithInsets(insetDimen: CGFloat) -> UIImage {
        return imageWithInset(insets: UIEdgeInsets(top: insetDimen, left: insetDimen, bottom: insetDimen, right: insetDimen))
    }
    
    func imageWithInset(insets: UIEdgeInsets) -> UIImage {
        let width: CGFloat      = self.size.width + insets.left + insets.right
        let height: CGFloat     = self.size.height + insets.top + insets.bottom
        let size: CGSize        = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets!
    }
    
    // MARK: - Upload image preparation
    class func uploadImagePreparation(pickedImage: UIImage) -> String {
        // We use document directory to place our cloned image
        let documentDirectory: NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        // Set static name, so everytime image is cloned, it will be named "temp", thus rewrite the last "temp" image.
        // *Don't worry it won't be shown in Photos app.
        let imageName = "temp_avatar.png"
        let imagePath = documentDirectory.appendingPathComponent(imageName)
        
        // Encode this image into JPEG. *You can add conditional based on filetype, to encode into JPEG or PNG
        if let data = UIImageJPEGRepresentation(pickedImage, 80) {
            // Save cloned image into document directory
            try! data.write(to: URL(fileURLWithPath: imagePath))
        }
        
        // Save it's path
        let localPath = imagePath
        return localPath
    }
}
