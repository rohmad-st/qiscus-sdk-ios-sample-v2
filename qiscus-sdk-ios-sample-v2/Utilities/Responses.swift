
//
//  Responses.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/10/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation

public enum Responses<T>{
    case done(T)
    case failed(message: String)
}
