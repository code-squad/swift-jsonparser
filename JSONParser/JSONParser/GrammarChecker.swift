//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 10..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    private let stringPattern : String
    private let intPattern : String
    private let boolPattern : String
    private let dictionaryPattern : String
    
    private let objectPattern : String
    private let arrayPattern : String
    
    enum ErrorMessage : Error {
        case notJSONPattern
    }
    
    init() {
        stringPattern = "[\\s]?\"[a-zA-Z\\d\\s]+\"[\\s]?"
        intPattern = "[\\s]?\\d+[\\s]?"
        boolPattern = "[\\s]?(true|false)[\\s]?"
        dictionaryPattern = "\(self.stringPattern):(\(self.stringPattern)|\(self.intPattern)|\(self.boolPattern))"
        objectPattern = "[\\{][\\s]?(\(self.dictionaryPattern)[,]?)+[\\s]?[\\}][\\s]?"
        arrayPattern = "\\[[\\s]?((\(self.stringPattern)|\(self.intPattern)|\(self.boolPattern)|\(self.objectPattern))[,]?)+[\\s]?\\][\\s]?"
    }
    
    func isJSONPattern(target: String) throws {
        guard isArrayPattern(target: target) || isObjectPattern(target: target) else {
            throw GrammarChecker.ErrorMessage.notJSONPattern
        }
    }
    
    private func isArrayPattern(target: String) -> Bool {
        guard target.starts(with: "[") else {
            return false
        }
        let arrayChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: self.arrayPattern, options: [])
        return getMatchResult(checker: arrayChecker, target: target)
    }
    
    private func isObjectPattern(target: String) -> Bool {
        guard target.starts(with: "{") else {
            return false
        }
        let objectChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: self.objectPattern, options: [])
        return getMatchResult(checker: objectChecker, target: target)
    }
    
    private func getMatchResult(checker: NSRegularExpression, target: String) -> Bool {
        let matchCount = checker.numberOfMatches(in: target, options: [], range: NSRange(location:0, length:target.count))
        guard matchCount == 1 else {
            return false
        }
        return true
    }
    
}
