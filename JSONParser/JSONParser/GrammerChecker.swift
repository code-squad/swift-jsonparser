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
        static let string = "\"[\\w\\s]+\""
        static let number = "[0-9]+"
        static let whiteSpace = "[\\s]*"
        static let value = "\(bool)|\(number)|\(string)"
        static let keyValue = "\(whiteSpace)\(string)\(whiteSpace):\(whiteSpace)[(\(number)|\(string)|\(bool)]*\(whiteSpace)"
        static let object = "\\{[[\(keyValue)][,]?]+\\}"
        static let extendedValue = "\(value)|\(object)"
        static let array = "(\\[(\(whiteSpace)(\(extendedValue))*\(whiteSpace))*])"
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
        let matchCount = regex.numberOfMatches(in: string, options: [], range: range) == 1
        return matchCount
    }
}
