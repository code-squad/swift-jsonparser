//
//  TokenType.swift
//  JSONParser
//
//  Created by 이동영 on 21/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum TokenType {
    case Array
    case Number
    case String
    case Boolean
    case None
    
    static func of(_ string: String) -> TokenType {
        if isArray(string) { return .Array }
        if isNumber(string) { return .Number }
        if isString(string) { return .String }
        if isBoolean(string) { return .Boolean }
        return .None
    }
    
    static func isArray(_ string: String) -> Bool {
        return ["[","]"].contains(string)
    }

    static func isNumber(_ string: String) -> Bool {
        guard Int.init(string) != nil else { return false }
        return true
    }
    
    static func isString(_ string: String) -> Bool {
        return string.first == "\"" && string.last == "\""
    }
    
    static func isBoolean(_ string: String) -> Bool {
        guard Bool.init(string) != nil else { return false }
        return true
    }
    
}
