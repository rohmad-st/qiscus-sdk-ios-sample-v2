//
//  ParseJSOn.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation

public func parseJsonFile(_ filename: String) -> [String: Any]? {
    do {
        if let file = Bundle.main.url(forResource: filename, withExtension: "json") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                // json is a dictionary
                print("JSON is dictionary", object)
                return object
                
            } else if let object = json as? [Any] {
                // json is an array
                print("JSON is array", object)
                return nil
                
            } else {
                print("JSON is invalid")
                return nil
            }
        } else {
            print("no file")
            return nil
        }
        
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        print("path of json file is: \(path)")
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    
    return nil
}
