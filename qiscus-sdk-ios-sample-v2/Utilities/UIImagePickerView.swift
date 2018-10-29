//
//  UIImagePickerView.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/24/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

protocol UIImagePickerViewDelegate {
    func didFinishPickImage(of image: UIImage)
}

class UIImagePickerView: NSObject {
    var delegate: UIImagePickerViewDelegate?
    
    func openImagePicker(_ sourceType: UIImagePickerControllerSourceType) {
        if sourceType == .camera {
            let cameraMediaType = AVMediaType.video
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)
            
            switch cameraAuthorizationStatus {
                
            // The client is authorized to access the hardware supporting a media type.
            case .authorized:
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = sourceType
                
                presentViewController(imagePicker)
                break
                
                // The client is not authorized to access the hardware for the media type. The user cannot change
            // the client's status, possibly due to active restrictions such as parental controls being in place.
            case .restricted:
                let alert = UIAlertController(title: NSLocalizedString("CAMERA_RESTRICTED",comment: "Camera restricted"), message: NSLocalizedString("CAMERA_RESTRICTED_DESCRIPTION", comment: "Camera restricted"), preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: NSLocalizedString("CANCEL", comment: "Cancel"), style: .cancel, handler: nil)
                alert.addAction(dismissAction)
                presentViewController(alert)
                break
                
            // The user explicitly denied access to the hardware supporting a media type for the client.
            case .denied:
                let alert = UIAlertController(
                    title: NSLocalizedString("CAMERA_DENIED",comment: "Camera denied"),
                    message: NSLocalizedString("CAMERA_DENIED_DESCRIPTION", comment: "Camera denied"),
                    preferredStyle: .alert)
                let changeAction = UIAlertAction(
                    title: NSLocalizedString("CHANGE_SETTING", comment: "Change Setting"),
                    style: .default,
                    handler: { action in
                        UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
                })
                
                alert.addAction(changeAction)
                let dismissAction = UIAlertAction(
                    title: NSLocalizedString("CANCEL", comment: "Cancel"),
                    style: .cancel,
                    handler: nil)
                alert.addAction(dismissAction)
                presentViewController(alert)
                
            // Indicates that the user has not yet made a choice regarding whether the client can access the hardware.
            case .notDetermined:
                // Prompting user for the permission to use the camera.
                AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                    if granted {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.allowsEditing = true
                        imagePicker.sourceType = sourceType
                        presentViewController(imagePicker)
                    }
                }
            }
            
        } else if sourceType == .photoLibrary {
            let libraryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            
            switch libraryAuthorizationStatus {
                
            // The client is authorized to access the hardware supporting a media type.
            case .authorized:
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = sourceType
                presentViewController(imagePicker)
                break
                
                // The client is not authorized to access the hardware for the media type. The user cannot change
            // the client's status, possibly due to active restrictions such as parental controls being in place.
            case .restricted:
                let alert = UIAlertController(
                    title: NSLocalizedString("PHOTO_LIBRARY_RESTRICTED",comment: "Photo library restricted"),
                    message: NSLocalizedString("PHOTO_LIBRARY_RESTRICTED_DESCRIPTION", comment: "Photo library restricted"),
                    preferredStyle: .alert)
                let dismissAction = UIAlertAction(
                    title: NSLocalizedString("CANCEL", comment: "Cancel"),
                    style: .cancel,
                    handler: nil)
                alert.addAction(dismissAction)
                presentViewController(alert)
                break
                
            // The user explicitly denied access to the hardware supporting a media type for the client.
            case .denied:
                let alert = UIAlertController(
                    title: NSLocalizedString("PHOTO_LIBRARY_DENIED",comment: "Photo library denied"),
                    message: NSLocalizedString("PHOTO_LIBRARY_DENIED_DESCRIPTION", comment: "Photo library denied"),
                    preferredStyle: .alert)
                let changeAction = UIAlertAction(
                    title: NSLocalizedString("CHANGE_SETTING", comment: "Change Setting"),
                    style: .default,
                    handler: { action in
                        UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
                })
                alert.addAction(changeAction)
                let dismissAction = UIAlertAction(
                    title: NSLocalizedString("CANCEL", comment: "Cancel"),
                    style: .cancel,
                    handler: nil)
                alert.addAction(dismissAction)
                presentViewController(alert)
                
            // Indicates that the user has not yet made a choice regarding whether the client can access the hardware.
            case .notDetermined:
                // Prompting user for the permission to use the camera.
                PHPhotoLibrary.requestAuthorization{ status in
                    switch status {
                    case .authorized:
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.allowsEditing = true
                        imagePicker.sourceType = sourceType
                        presentViewController(imagePicker)
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
}

extension UIImagePickerView: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismiss(animated: true, completion: { () in
            self.delegate?.didFinishPickImage(of: image)
        })
    }
}

extension UIImagePickerView: UINavigationControllerDelegate {
    //
}
