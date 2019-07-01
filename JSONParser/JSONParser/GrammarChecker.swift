//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by JieunKim on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    private static func isValidArray(input: String) -> Bool {
        return input.range(of: Regex.array, options: .regularExpression) != nil
    }
    
    private static func isValidObject(input: String) -> Bool {
        return input.range(of: Regex.object, options: .regularExpression) != nil
    }
    
    static func isValid(_ input: String) -> Bool {
        return isValidArray(input: input) || isValidObject(input: input)
    }
}

struct Regex {
    private static let string =  "\"[^\"]*\""
    private static let number = "[0-9]*"
    private static let bool = "(true|false)"
    private static let ws = "\\s*"
    private static let value = "\(string)|\(bool)|\(number)"
    
    private static let nestedObject = "\\{\(ws)((|,\(ws))(\(string)\(ws):\(ws))(\(value)))+\(ws)\\}"
    private static let nestedArray = "\\[\(ws)((|,\(ws))(\(value)))+\(ws)\\]"
    
    static let object = "^\\{\(ws)((|,\(ws))(\(string)\(ws):\(ws))(\(value)|(\(nestedArray))|(\(nestedObject))))+\(ws)\\}$"
    static let array = "^\\[\(ws)((|,\(ws))(\(value)|(\(nestedObject))|(\(nestedArray))))+\(ws)\\]$"
}
