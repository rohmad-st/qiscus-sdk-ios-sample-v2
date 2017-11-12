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
        if let email = pref.string(forKey: "email") {
            return email
        } else {
            return ""
        }
    }
    
    func getLocal() -> PrefData {
        let appId       = pref.string(forKey: "appId") ?? ""
        let email       = pref.string(forKey: "email") ?? ""
        let username    = pref.string(forKey: "username") ?? ""
        let password    = pref.string(forKey: "password") ?? ""
        
        return PrefData(appId: appId,
                        email: email,
                        password: password,
                        username: username)!
    }
    
    func setLocal(preference data: PrefData) {
        if let appId = data.appId {
            pref.set(appId, forKey: "appId")
        }
        if let email = data.email {
            pref.set(email, forKey: "email")
        }
        if let username = data.username {
            pref.set(username, forKey: "username")
        }
        if let password = data.password {
            pref.set(password, forKey: "password")
        }
        sync()
    }

    func clearAll(){
        pref.removeObject(forKey: "appId")
        pref.removeObject(forKey: "email")
        pref.removeObject(forKey: "password")
        pref.removeObject(forKey: "username")
        pref.synchronize()
    }
    
    func sync(){
        pref.synchronize()
    }
    
}

class PrefData {
    var appId: String?
    var email: String?
    var password: String?
    var username: String?
    
    init?(appId: String, email: String, password: String, username: String) {
        self.appId = appId
        self.email = email
        self.password = password
        self.username = username
    }
}
