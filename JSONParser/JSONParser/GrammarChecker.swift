//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 10..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {

    func isJSONPattern(target: String) -> Bool {
        return isArrayPattern(target: target) || isObjectPattern(target: target)
    }
    
    private func isArrayPattern(target: String) -> Bool {
        guard target.starts(with: "[") else {
            return false
        }
        return getMatchResult(with: JSONPatterns.nestedArrayPattern, target: target)
    }
    
    private func isObjectPattern(target: String) -> Bool {
        guard target.starts(with: "{") else {
            return false
        }
        return getMatchResult(with: JSONPatterns.nestedObjectPattern, target: target)
    }
    
    private func getMatchResult(with pattern: String, target: String) -> Bool {
        let regularExpression = try! NSRegularExpression.init(pattern: pattern, options: [])
        let matchCount = regularExpression.numberOfMatches(in: target, options: [], range: NSRange(location:0, length:target.count))
        if matchCount != 1 {
            return false
        }
        return true
    }

    func isInsideArrayPattern(target: String) -> Bool {
        return getMatchResult(with: JSONPatterns.insideArrayPattern, target: target)
    }
    
}
