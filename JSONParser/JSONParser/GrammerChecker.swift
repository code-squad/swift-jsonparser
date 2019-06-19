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
        static let value = "(\(bool)|\(number)|\(string))"
        static let keyValue = "\(whiteSpace)\(string)\(whiteSpace):\(whiteSpace)(\(number)|\(string)|\(bool))*\(whiteSpace),?"
        static let object = "\\{((\(keyValue))?\(whiteSpace))*\\}"
        static let valueWithObject = "(\(value)|\(object))"
        static let array = "\\[(\(whiteSpace)\(valueWithObject)?\(whiteSpace),?)*\\]"
    }
    
    static func isJSONFormat(of input: String) -> Bool {
        guard containsMatch(of: Pattern.array, inString: input) else {
            return containsMatch(of: Pattern.object, inString: input)
        }
        return true
    }
    
    static private func containsMatch(of pattern: String, inString string: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let range = NSRange(string.startIndex..., in: string)
        guard let matchResult = regex.firstMatch(in: string, options: [], range: range) else {
            return false
        }
        return matchResult.range == range
    }
}
