//
//  Date.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/15/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation

extension Date {
    func today() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func yesterday() -> Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    func year() -> Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    
    func offsetFromInSecond(date:Date) -> Int{
        let differerence = Calendar.current.dateComponents([.second], from: date, to: self)
        if let secondDiff = differerence.second {
            return secondDiff
        } else {
            return 0
        }
    }
}
