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
    private let arrayCheckPatten = "(\\d+)|(\"\\w+\")|(true|false)|(([\\{])(.*:.[^\\[\\]]*)([\\}]))"
    
    func checkObject(inString string: [String]) throws -> [String] {
        guard (try? NSRegularExpression(pattern: objectCheckPatten, options: [])) != nil else {
            throw JSONParser.ErrorCode.invalidPatten
        }
        return string
    }
    
    func checkArray(inString value: String) throws -> String {
        let numberOfComma = value.filter{ $0 == "," }
        let numberOfGroup = try listNumberOfGroup(pattern: arrayCheckPatten, inString: value)
        if (numberOfComma.count + 1) != numberOfGroup {
            throw JSONParser.ErrorCode.invalidPatten
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
        let range = NSMakeRange(0, value.count)
        guard let matches = regex.firstMatch(in: value, options: [], range: range) else {
            throw JSONParser.ErrorCode.invalidJSONStandard
        }
        let arrMatches = [matches]
        return arrMatches.map {
            let range = $0.range
            return (value as NSString).substring(with: range)
        }
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
    var fullRange: NSRange { return NSRange(location:0, length: self.count)}
    func range(from r:NSRange) -> Range<Index> {
        let s = index(startIndex, offsetBy: r.location)
        let e = index(s, offsetBy: r.length)
        return s..<e
    }
}
