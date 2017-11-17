//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 10..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    // basic pattern
    private let stringPattern : String
    private let intPattern : String
    private let boolPattern : String
    private let dictionaryPattern : String
    let objectPattern : String
    let arrayPattern : String
    // nested pattern
    let nestedDictionaryPattern : String
    let nestedObjectPattern : String
    let nestedArrayPattern : String
    
    enum ErrorMessage : Error {
        case notJSONPattern
    }
    
    init() {
        stringPattern = "[\\s]*\"[^\"]+\"[\\s]*"
        intPattern = "[\\s]*\\d+[\\s]*"
        boolPattern = "[\\s]*(true|false)[\\s]*"
        dictionaryPattern = "\(self.stringPattern):(\(self.stringPattern)|\(self.intPattern)|\(self.boolPattern))"
        objectPattern = "[\\s]*\\{(\(self.dictionaryPattern)[,]?)+[\\s]*\\}[\\s]*"
        arrayPattern = "[\\s]*\\[((\(self.stringPattern)|\(self.intPattern)|\(self.boolPattern)|\(self.objectPattern))[,]?)+[\\s]*\\][\\s]*"
        
        nestedDictionaryPattern = "\(self.stringPattern):(\(self.stringPattern)|\(self.intPattern)|\(self.boolPattern)|\(self.objectPattern)|\(self.arrayPattern))"
        nestedObjectPattern = "[\\s]*?\\{(\(self.nestedDictionaryPattern)[,]?)+[\\s]*?\\}[\\s]*?"
        nestedArrayPattern = "[\\s]*?\\[((\(self.stringPattern)|\(self.intPattern)|\(self.boolPattern)|\(self.nestedObjectPattern)|\(self.arrayPattern))[,]?)+[\\s]*?\\][\\s]*?"
    }
    
    func isJSONPattern(target: String) -> Bool {
        return isArrayPattern(target: target) || isObjectPattern(target: target)
    }
    
    private func isArrayPattern(target: String) -> Bool {
        guard target.starts(with: "[") else {
            return false
        }
        return getMatchResult(with: nestedArrayPattern, target: target)
    }
    
    private func isObjectPattern(target: String) -> Bool {
        guard target.starts(with: "{") else {
            return false
        }
        return getMatchResult(with: nestedObjectPattern, target: target)
    }
    
    private func getMatchResult(with pattern: String, target: String) -> Bool {
        let regularExpression = try! NSRegularExpression.init(pattern: pattern, options: [])
        let matchCount = regularExpression.numberOfMatches(in: target, options: [], range: NSRange(location:0, length:target.count))
        if matchCount != 1 {
            return false
        }
        return true
    }
    
}
