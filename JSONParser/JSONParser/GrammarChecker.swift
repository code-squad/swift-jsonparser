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
    
    private let nestedDictionaryPattern : String
    private let nestedObjectPattern : String
    private let nestedArrayPattern : String
    
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
        
        nestedDictionaryPattern = "\(self.stringPattern):(\(self.stringPattern)|\(self.intPattern)|\(self.boolPattern)|\(self.objectPattern)|\(self.arrayPattern))"
        nestedObjectPattern = "[\\s]?[\\{][\\s]?((\(self.nestedDictionaryPattern))[,]?)+[\\s]?[\\}][\\s]?"
        nestedArrayPattern = "[\\s]?[\\[][\\s]?((\(self.stringPattern)|\(self.intPattern)|\(self.boolPattern)|\(self.nestedObjectPattern)|\(self.arrayPattern))[,]?)+[\\s]?[\\]][\\s]?"
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
        let arrayChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: self.nestedArrayPattern, options: [])
        return getMatchResult(checker: arrayChecker, target: target)
    }
    
    private func isObjectPattern(target: String) -> Bool {
        guard target.starts(with: "{") else {
            return false
        }
        let objectChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: self.nestedObjectPattern, options: [])
        return getMatchResult(checker: objectChecker, target: target)
    }
    
    private func getMatchResult(checker: NSRegularExpression, target: String) -> Bool {
        let matchCount = checker.numberOfMatches(in: target, options: [], range: NSRange(location:0, length:target.count))
        guard matchCount == 1 else {
            return false
        }
        return true
    }
    
    func getArrayMatches(from target: String) -> Array<String> {
        let arrayChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: arrayPattern, options: [])
        let arrayResult = arrayChecker.matches(in: target, options: [], range: NSRange(location:0, length:target.count))
        let result = arrayResult.map {String(target[Range($0.range, in: target)!]).trimmingCharacters(in: .whitespaces)}
        return result
    }
    
    func getObjectMatches(from target: String) -> Array<String> {
        let objectChecker : NSRegularExpression = try! NSRegularExpression.init(pattern: objectPattern, options: [])
        let objectResult = objectChecker.matches(in: target, options: [], range: NSRange(location:0, length:target.count))
        let result = objectResult.map {String(target[Range($0.range, in: target)!]).trimmingCharacters(in: .whitespaces)}
        return result
    }
    
}
