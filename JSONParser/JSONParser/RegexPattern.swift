//
//  RegexPattern.swift
//  JSONParser
//
//  Created by Daheen Lee on 20/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct RegexPattern {
    static private let string    = "\"[^\"]*\""
    static private let objectKey = "\"[^\"]+\""
    static private let number    = "[\\d]+"
    static private let bool      = "true|false"
    static private let orOperator = "|"
    static private let whitespace = "\\s*"
    static private let startWith = "^"
    static private let end       = "$"
    static private let doubleBackslash = "\\"
    static private let openBracket = doubleBackslash + String(JSONSymbols.openBracket)
    static private let closedBracket = doubleBackslash + String(JSONSymbols.closedBracket)
    static private let openBrace = doubleBackslash + String(JSONSymbols.openBrace)
    static private let closedBrace = doubleBackslash + String(JSONSymbols.closedBrace)
    static private let openParenthesis = "("
    static private let closedParenthesis = ")"
    static private let colon = doubleBackslash + String(JSONSymbols.colon)
    
    static var plainValueGroup: String {
        get {
            return openParenthesis + bool + orOperator + string + orOperator + number + closedParenthesis
        }
    }
    
    static var nestedValueGroup: String {
        get {
            return openParenthesis + bool + orOperator + string + orOperator + number + orOperator + plainArray + orOperator + plainObject + closedParenthesis
        }
    }
    
    static var plainArray: String {
        get {
            return openBracket + whitespace + plainValueGroup + whitespace + getOptionalPattern(for: plainValueGroup) + whitespace + closedBracket
        }
    }
    
    static var plainObject: String {
        get {
            let element = objectKey + whitespace + colon + whitespace + plainValueGroup
            return openBrace + whitespace + element + whitespace + getOptionalPattern(for: element) + whitespace + closedBrace
        }
    }
    
    static var nestedArray: String {
        get {
            return startWith + openBracket + whitespace + nestedValueGroup + whitespace + getOptionalPattern(for: nestedValueGroup) + whitespace + closedBracket + end
        }
    }
    
    static var nestedObject: String {
        get {
            let element = objectKey + whitespace + colon + whitespace + nestedValueGroup
            return startWith + openBrace + whitespace + element + whitespace + getOptionalPattern(for: element) + whitespace + closedBrace + end
        }
    }
    
    static private func getOptionalPattern(for element: String) -> String {
        return "((?:," + whitespace + element + ")*)"
    }
}
