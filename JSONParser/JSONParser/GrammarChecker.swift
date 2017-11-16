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
    private let objectPattern : String
    private let arrayPattern : String
    // nested pattern
    private let nestedDictionaryPattern : String
    private let nestedObjectPattern : String
    private let nestedArrayPattern : String
    
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
    
    func isJSONPattern(target: String) throws {
        guard isArrayPattern(target: target) || isObjectPattern(target: target) else {
            throw GrammarChecker.ErrorMessage.notJSONPattern
        }
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
        guard matchCount == 1 else {
            return false
        }
        return true
    }
    // 배열 내부의 배열 추출
    func getArrayMatches(from target: String) -> Array<String> {
        return getMatchedElements(from: target, with: arrayPattern)
    }
    // 배열 내부의 객체 추출
    func getObjectMatches(from target: String) -> Array<String> {
        return getMatchedElements(from: target, with: objectPattern)
    }

    private func getMatchedElements(from target: String, with pattern: String) -> Array<String> {
        let regularExpression = try! NSRegularExpression.init(pattern: pattern, options: [])
        let objectResult = regularExpression.matches(in: target, options: [], range: NSRange(location:0, length:target.count))
        let result = objectResult.map {String(target[Range($0.range, in: target)!]).trimmingCharacters(in: .whitespaces)}
        return result
    }
    
    func removeMatchedArray(target: String) -> String {
        return removeMatchedElements(from: target, with: arrayPattern)
    }
    
    func removeMatchedObject(target: String) -> String {
        return removeMatchedElements(from: target, with: objectPattern)
    }

    private func removeMatchedElements(from target: String, with pattern: String) -> String {
        let regularExpression = try! NSRegularExpression.init(pattern: pattern, options: [])
        let result = regularExpression.stringByReplacingMatches(in: target, options: [], range: NSRange(location:0, length: target.count), withTemplate: "")
        return result
    }
    // JSONObject 타입에서 요소 추출
    func getObjectElements(from target: String) -> Array<String> {
        return getMatchedElements(from: target, with: nestedDictionaryPattern)
    }
    
}
