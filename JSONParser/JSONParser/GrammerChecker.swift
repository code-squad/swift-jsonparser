//
//  GrammerChecker.swift
//  JSONParser
//
//  Created by CHOMINJI on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammerChecker {
    
    struct Pattern {
        static let bool = "(true|false)"
        static let string = "\"[^\"]+\""
        static let number = "[0-9]+"
        static let whiteSpace = "\\s*"
        
        static var value = "(\(bool)|\(number)|\(string))"
        static let keyValue = "\(whiteSpace)\(string)\(whiteSpace):\(whiteSpace)\(value)*\(whiteSpace),?"
        static let object = "(\\{((\(keyValue))?\(whiteSpace))*\\})"
        static let array = "(\\[(\(whiteSpace)\(value)?\(whiteSpace),?)*\\])"
        
        static let valueWithContainer = "(\(value)|\(object)|\(array))"
        static let keyValueWithContainer = "\(whiteSpace)\(string)\(whiteSpace):\(whiteSpace)\(valueWithContainer)*\(whiteSpace),?"
        static let nestedObject = "\\{((\(keyValueWithContainer))?\(whiteSpace))*\\}"
        static let nestedArray = "\\[(\(whiteSpace)\(valueWithContainer)?\(whiteSpace),?)*\\]"
    }
    
    static func isJSONFormat(of input: String) -> Bool {
        guard containsMatch(of: Pattern.nestedArray, inString: input) else {
            return containsMatch(of: Pattern.nestedObject, inString: input)
        }
        return true
    }
    
    static private func containsMatch(of pattern: String, inString string: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let range = NSRange(string.startIndex..., in: string)
        let matchRange = regex.rangeOfFirstMatch(in: string, options: [], range: range)
        return matchRange == range
    }
}
