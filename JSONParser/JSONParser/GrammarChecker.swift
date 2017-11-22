//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    private let objectCheckPatten = "(([\\{])(.*:.[^\\[\\]]*)([\\}]))"
    private let arrayCheckPatten = "(\\{[^\\{\\}]*\\})|(true|false)|(\\d+)|(\".+?\")|(:)"
    
    func checkObject(inString value: String) throws -> String {
        let numberOfGroup = try listNumberOfGroup(pattern: objectCheckPatten, inString: value)
        if  numberOfGroup == 0 {
            throw JSONParser.ErrorCode.invalidJSONStandard
        }
        return value
    }
    
    func checkArray(inString value: String) throws -> String {
        let separateString = try listMatches(pattern: arrayCheckPatten, inString: value)
        if (separateString.contains(":"))  {
            throw JSONParser.ErrorCode.invalidJSONStandard
        } else {
            return value
        }
    }
    
}

extension GrammarChecker {
    func listMatches(pattern: String, inString value: String) throws -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            throw JSONParser.ErrorCode.invalidJSONStandard
        }
        let results = regex.matches(in: value, options: [], range: NSRange(value.startIndex..., in: value))
        return results.map{ String(value[Range($0.range, in: value)!]) }
    }
    
    func listNumberOfGroup(pattern: String, inString value: String) throws -> Int {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            throw JSONParser.ErrorCode.invalidPatten
        }
        let matches = regex.numberOfMatches(in: value, options: [], range: value.fullRange)
        return matches
    }
}

extension String {
    var fullRange: NSRange { return NSRange(location:0, length: self.count) }
    func range(from range:NSRange) -> Range<Index> {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(start, offsetBy: range.length)
        return start..<end
    }
}
