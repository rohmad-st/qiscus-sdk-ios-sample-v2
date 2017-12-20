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
            return "qiscuscs-5xm3wgs5fc1p"
        }
    }
    
    static var BASE_URL: String {
        get {
            return "https://qiscuscs-admin.herokuapp.com" // CHANGE THIS WITH YOUR OWN URL
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
    
    static var URL_CONTACTS: String {
        get {
            return "\(BASE_URL)/api/contacts?show_all=true"
        }
    }
    
    static func urlContacts(of page: Int, limit: Int = 10) -> String {
        return "\(BASE_URL)/api/contacts?page=\(page)&limit=\(limit)"
    }
    
    static var URL_UPLOAD: String {
        get {
            return "https://\(APP_ID).qiscus.com/api/v2/sdk/upload"
        }
    }
    
    static func getLocalization() -> String{
        let localization:String = (Locale.current as NSLocale).object(forKey: NSLocale.Key.languageCode)! as! String
        return localization
    }
}
