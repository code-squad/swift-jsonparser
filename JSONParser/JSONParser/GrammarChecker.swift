//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 이진영 on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    private static let string = "\"[a-zA-Z0-9', ]+\""
    private static let number = "[0-9]+"
    private static let bool = "(true|false)"
    private static let ws = " ?"
    
    private static let nestedObject = "\\{\(ws)((|,\(ws))(\(string)\(ws):\(ws))(\(string)|\(number)|\(bool)))+\(ws)\\}"
    private static let nestedArray = "\\[\(ws)((|,\(ws))(\(string)|\(number)|\(bool)))+\(ws)\\]"
    
    private static let objectRegex = "^\\{\(ws)((|,\(ws))(\(string)\(ws):\(ws))(\(string)|\(number)|\(bool)|(\(nestedArray))|(\(nestedObject))))+\(ws)\\}$"
    private static let arrayRegex = "^\\[\(ws)((|,\(ws))(\(string)|\(number)|\(bool)|(\(nestedObject))|(\(nestedArray))))+\(ws)\\]$"
    
    static func checkGrammar(input: String) -> Bool {
        let isArray = input.range(of: arrayRegex, options: .regularExpression) != nil
        let isObject = input.range(of: objectRegex, options: .regularExpression) != nil
        
        return isArray || isObject
    }
}
