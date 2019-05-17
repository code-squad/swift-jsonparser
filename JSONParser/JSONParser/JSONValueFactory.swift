//
//  JSONValueFactory.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONValueFactory {
    static let trueString = "true"
    static let falseString = "false"
    
    static func make(token: String) -> JSONValue {
        if token.first == JSONSymbols.doubleQuotation {
            return String(token)
        }
        if token == trueString {
            return true
        }
        if token == falseString {
            return false
        }
        return Int(token)!
    }
    
}
