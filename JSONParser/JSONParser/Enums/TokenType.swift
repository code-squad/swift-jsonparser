//
//  TokenType.swift
//  JSONParser
//
//  Created by 이동영 on 21/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum TokenType: String {
    case Array = "배열"
    case Number = "숫자"
    case String = "문자열"
    case Boolean = "부울"
    case None = "X"
    
    static func of(_ string: String) -> TokenType {
        if isArray(string) { return .Array }
        if isNumber(string) { return .Number }
        if isString(string) { return .String }
        if isBoolean(string) { return .Boolean }
        return .None
    }
    
    private static func isArray(_ string: String) -> Bool {
        return ["[","]"].contains(string)
    }

    private static func isNumber(_ string: String) -> Bool {
        guard Int.init(string) != nil else { return false }
        return true
    }
    
    private static func isString(_ string: String) -> Bool {
        return string.first == "\"" && string.last == "\""
    }
    
    private static func isBoolean(_ string: String) -> Bool {
        guard Bool.init(string) != nil else { return false }
        return true
    }
    
}
extension TokenType: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
