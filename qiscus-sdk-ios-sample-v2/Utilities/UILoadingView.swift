//
//  UILoadingView.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/8/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import UIKit
import PKHUD

protocol UILoadingView {
    func showWaiting(message: String)
    func dismissLoading()
    func showError(message: String)
    func showSuccess(message: String)
    func showNetworkActivityIndicator()
    func dismissNetworkActivityIndicator()
}

extension UILoadingView where Self : UIViewController{
    func showNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func dismissNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    func showWaiting(message: String) {
        HUD.show(.labeledProgress(title: "Processing", subtitle: message))
    }
    func dismissLoading() {
        HUD.hide()
    }
    func showError(message: String) {
        HUD.flash(.labeledError(title: "Warning", subtitle: message), delay: 1.00)
    }
    func showSuccess(message: String) {
        HUD.flash(.labeledSuccess(title: "Success", subtitle: message), delay: 1.00)
    }
}
