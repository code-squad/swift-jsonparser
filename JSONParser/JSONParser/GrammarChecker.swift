//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by JH on 01/07/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    static let stringPattern = "\"[^\"]*\""
    static let numberPattern = "\\d+(\\.\\d+)?"
    static let boolPattern = "true|false"
    
    static let valuePattern = "(?:\(stringPattern)|\(numberPattern)|\(boolPattern))"
    
    static let arrayPattern = "\\[\\s*(?:\(valuePattern)\\s*(?:,\\s*\(valuePattern)\\s*)*)?\\]"
    
    static let objectStringValue = "(?:\(stringPattern)\\s*:\\s*\(valuePattern)\\s*)"
    static let objectPattern = "\\{\\s*(?:\(objectStringValue)\\s*(?:,\\s*\(objectStringValue))*)?\\}"
    
    //중첩구조에관한 정규식
    static let jsonValuePattern = "(?:\(valuePattern)|\(arrayPattern)|\(objectPattern))"
    
    static let newArrayPattern = "\\[\\s*(?:\(jsonValuePattern)\\s*(?:,\\s*\(jsonValuePattern)\\s*)*)?\\]"
    
    static let newObjectStringValue = "(?:\(stringPattern)\\s*:\\s*\(jsonValuePattern)\\s*)"
    static let newObjectPattern = "\\{\\s*(?:\(newObjectStringValue)\\s*(?:,\\s*\(newObjectStringValue))*)?\\}"

    static let jsonPattern = "\(stringPattern)|\(numberPattern)|\(boolPattern)|\(newArrayPattern)|\(newObjectPattern)"
    
    var regularExpression = try! NSRegularExpression(pattern: jsonPattern)
    
    
    func checkGrammar(input: String) -> Bool {
        return regularExpression.numberOfMatches(in: input, range: NSRange(location: 0, length: input.count)) == 1
    }
    
    
}
