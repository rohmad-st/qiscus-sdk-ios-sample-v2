//
//  Preference.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/11/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation

class Preference {
    private var pref    = UserDefaults.standard
    static let instance = Preference()
    
    func getEmail() -> String {
        if let email = pref.string(forKey: PrefType.email.rawValue) {
            return email
        } else {
            return ""
        }
    }
    
    func getLocal() -> PrefData {
        let appId       = pref.string(forKey: PrefType.appId.rawValue) ?? ""
        let email       = pref.string(forKey: PrefType.email.rawValue) ?? ""
        let username    = pref.string(forKey: PrefType.username.rawValue) ?? ""
        let password    = pref.string(forKey: PrefType.password.rawValue) ?? ""
        let avatarURL   = pref.string(forKey: PrefType.avatarURL.rawValue) ?? ""
        
        return PrefData(appId: appId,
                        email: email,
                        password: password,
                        username: username,
                        avatarURL: avatarURL)!
    }
    
    func setLocal(preference data: PrefData) {
        if let appId = data.appId {
            pref.set(appId, forKey: PrefType.appId.rawValue)
        }
        if let email = data.email {
            pref.set(email, forKey: PrefType.email.rawValue)
        }
        if let username = data.username {
            pref.set(username, forKey: PrefType.username.rawValue)
        }
        if let password = data.password {
            pref.set(password, forKey: PrefType.password.rawValue)
        }
        if let avatarURL = data.avatarURL {
            pref.set(avatarURL, forKey: PrefType.avatarURL.rawValue)
        }
        sync()
    }

    func clearAll(){
        pref.removeObject(forKey: PrefType.appId.rawValue)
        pref.removeObject(forKey: PrefType.email.rawValue)
        pref.removeObject(forKey: PrefType.password.rawValue)
        pref.removeObject(forKey: PrefType.username.rawValue)
        pref.removeObject(forKey: PrefType.avatarURL.rawValue)
        pref.synchronize()
    }
    
    func sync(){
        pref.synchronize()
    }
    
}

enum PrefType: String {
    case appId      = "appId"
    case email      = "email"
    case password   = "password"
    case username   = "username"
    case avatarURL  = "avatarURL"
}

class PrefData {
    var appId: String?
    var email: String?
    var password: String?
    var username: String?
    var avatarURL: String?
    
    init?(appId: String, email: String, password: String, username: String, avatarURL: String) {
        self.appId = appId
        self.email = email
        self.password = password
        self.username = username
        self.avatarURL = avatarURL
    }
}
