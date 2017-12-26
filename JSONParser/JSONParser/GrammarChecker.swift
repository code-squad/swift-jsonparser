//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation


struct GrammarChecker {
    
    let arrayPattern = "true|false|\".+?\"|\\d+|\\{.+?\\}|:"
    let objectPattern = "(\".+?\")\\:(true|false|\\\".+?\\\"|\\d+|\\[.+?\\])"
    let arrayValuePattern = "(true|false)|(\\{.*\\})|(\\d+)|(\".*\")|(\\[.*\\])"
    let objectValuePattern = "(\".*\"):((true|false)|(\\{.*\\})|(\\d+)|(\".*\")|(\\[.*\\]))"

    enum FormatError: Error {
        case invalidArray
        case invalidObject
        
        var description: String {
            switch self {
            case .invalidArray:
                return "지원하지 않는 배열 형식입니다."
            case .invalidObject:
                return "지원하지 않는 객체 형식입니다."
            }
        }
    }
    
    func execute (_ input: String) throws -> [String] {
        if input.hasPrefix("[") && input.hasSuffix("]") {
            if checkArray(input) {
               return checkArrayFormat(input)
            } else {
                throw GrammarChecker.FormatError.invalidArray
            }
        }
        if input.hasPrefix("{") && input.hasSuffix("}") {
            if checkObject(input) {
               return checkObjectFormat(input)
            } else {
                throw GrammarChecker.FormatError.invalidObject
            }
        }
        return []
    }
    
    // #1. Array - format check
    private func checkArrayFormat (_ input: String) -> [String] { 
        do {
            let regex = try NSRegularExpression(pattern: arrayPattern)
            let nsInput = input as NSString
            let matches = regex.matches(in: input, range: NSRange(location: 0, length: nsInput.length))
            let matchValues = matches.map{nsInput.substring(with: $0.range)}
            return matchValues
        } catch {
            return []
        }
    }
    
    // #2. Array - value check
    private func checkArrayValue (_ value: String) -> Bool {
        var matchValue = [String]()
        do {
            let regex = try NSRegularExpression(pattern: arrayValuePattern)
            let nsInput = value as NSString
            let matches = regex.matches(in: value, range: NSRange(location: 0, length: nsInput.length))
            matchValue = matches.map{nsInput.substring(with: $0.range)}
        } catch {
            matchValue = []
        }
        if matchValue != [] {
            return true
        } else {
            return false
        }
    }
    
    // Array - #1, #2 execute
    func checkArray (_ input: String) -> Bool {
        let formatMatchValues = checkArrayFormat(input)
        for value in formatMatchValues {
            if checkArrayValue(value) {
                return true
            } else {
                return false
            }
        }
        return false
    }

    // #1. Object - format Check
    private func checkObjectFormat (_ input: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: objectPattern)
            let nsInput = input as NSString
            let matches = regex.matches(in: input, range: NSRange(location: 0, length: nsInput.length))
            let matchValues = matches.map{nsInput.substring(with: $0.range)}
            return matchValues
        } catch {
            return []
        }
    }

    // 2. Object - value check
    private func checkObjectValue (_ value: String) -> Bool {
        var matchValue = [String]()
        do {
            let regex = try NSRegularExpression(pattern: objectValuePattern)
            let nsInput = value as NSString
            let matches = regex.matches(in: value, range: NSRange(location: 0, length: nsInput.length))
            matchValue = matches.map{nsInput.substring(with: $0.range)}
        } catch {
            matchValue = []
        }
        if matchValue != [] {
            return true
        } else {
            return false
        }
    }
    
    // Object - #1, #2 execute
    func checkObject (_ input: String) -> Bool {
        let formatMatchValues = checkObjectFormat(input)
        for value in formatMatchValues {
            if checkObjectValue(value) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    

}
