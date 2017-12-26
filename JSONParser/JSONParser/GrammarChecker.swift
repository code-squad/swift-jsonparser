//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 22..
//  Copyright © 2017년 JK. All rights reserved.
//
import Foundation

extension NSRegularExpression {
    convenience init(pattern : String) {
        try! self.init(pattern: pattern, options : [])
    }
}

extension String {
    func isMatching(expression: NSRegularExpression) -> Bool {
        return expression.numberOfMatches(in: self, range: NSRange(location: 0, length: self.count)) > 0
    }
}

struct GrammarChecker {
//    let stringPattern = "[\\s]*(\"\\w\")[\\s]*"
//    let numberPattern = "[\\s]*(\\d)[\\s]*"
//    let boolPattern  = "[\\s]*(true|false)[\\s]*"
//    let dictionaryPattern = "(\\{)[\\s]*(\"\\w\")[\\s]*:[\\s]*((\"\\w\")|(\\d)|(true|false))[\\s]*(\\})"
//    let dataPattern = "[\\s]*((\"\\w\")|(\\d)|(true|false))[\\s]*"
    
    let arrayPattern  = "[\\s]*(\\[)[[\\s]*((\"\\w\")|(\\d)|(true|false)|(\\{)[\\s]*(\"\\w\")[\\s]*:[\\s]*((\"\\w\")|(\\d)|(true|false))[\\s]*(\\}))(\\])*(,)*[\\s]*]+(\\])"
    let objectPattern  = "[\\s]*(\\{)[[\\s]*(\"\\w\")[\\s]*:[\\s]*((\"\\w\")|(\\d)|(true|false))[\\s]*(\\})*(,)*[\\s]*]+(\\})"
    
    func isValid(userInput : String) -> Bool {
        if isValidArray(userInput) == true || isValidObject(userInput) == true {
            return true
        }
        print("지원하는 형식이 아닙니다. 다시 입력해주세요.")
        return false
    }
    
    private func isValidArray(_ userInput : String) -> Bool {
        return userInput.isMatching(expression: NSRegularExpression(pattern : arrayPattern))
    }
    
    private func isValidObject(_ userInput : String) -> Bool {
        return userInput.isMatching(expression: NSRegularExpression(pattern : objectPattern))
    }
}
