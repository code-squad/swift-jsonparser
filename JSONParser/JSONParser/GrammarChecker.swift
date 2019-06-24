//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by JieunKim on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static func isValidArray(input: String) -> Bool {
       return input.range(of: Regex.array, options: .regularExpression) != nil
    }
    
    static func isValidObject(input: String) -> Bool {
        return input.range(of: Regex.object, options: .regularExpression) != nil
    }
    
    static func isValid(_ input: String) -> Bool {
        return isValidArray(input: input) || isValidObject(input: input)
    }
}

struct Regex {
    private static let bool = "(true|false)"
    private static let ws = "\\s*"
    private static let string = "\"[^\"]*\""
    private static let number = "[0-9]*"
    private static let key = "\(ws))\(string)\(ws)"
    private static let value = "\(string)|\(bool)|\(number)"
    private static let keyValue = "\(key):(\(ws))(\(value))\(ws)"
    static let object = "\\{((\(keyValue),?\(ws))*\\}"
    static let array = "\\[(\(ws))?((\(object)|\(value))(\(ws))?(,)?(\(ws))?)*\\]"
}
