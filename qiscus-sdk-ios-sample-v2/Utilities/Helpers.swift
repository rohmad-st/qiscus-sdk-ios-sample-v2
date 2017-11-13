//
//  Helpers.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/7/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//
import Foundation
import Alamofire

class Helper: NSObject {
    static var APP_ID: String {
        get {
            return "sampleapp-65ghcsaysse"
        }
    }
    static var USER_EMAIL: String {
        get {
            return "piyut@qiscus.com"
        }
    }
    static var USER_PASSWORD: String {
        get {
            return "qiscus-123"
        }
    }
    static var USER_USERNAME: String {
        get {
            return "piyut"
        }
    }
    static var USER_AVATAR_URL: String {
        get {
            return "https://pbs.twimg.com/profile_images/509529944431407104/PJITGbsA_400x400.jpeg"
        }
    }
    
    static var headers : HTTPHeaders {
        get {
            return [
                "platform": "ios",
                "lang": self.getLocalization()
            ]
        }
    }
    
    static func getLocalization() -> String{
        let localization:String = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode)! as! String
        return localization
    }
}
