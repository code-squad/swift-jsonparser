//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    public static func isValidate(to inputValue:String) throws {
        // 배열 형식 검사
        if inputValue.isArray() {
            guard inputValue.supportedArrayTypes() else {
                throw JsonError.unSupportedArrayPattern
            }
        }
        
        // 객체 형식 검사
        if inputValue.isObject() {
            guard inputValue.supportedObjectTypes() else {
                throw JsonError.unSupportedObjectPattern
            }
        }
    }
    
}

extension String {
    // 숫자 검사 : 있으면 return true OR 없으면 return false
    func isNumber() -> Bool {
        var result = false
        if let regex = try? NSRegularExpression(pattern: Regex.numberType , options: []){
            let string = self as NSString
            result = !regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return result
    }
    
    // Bool 검사 : 맞으면 return true OR 아니면 return false
    func isBool() -> Bool {
        var result = false
        if let regex = try? NSRegularExpression(pattern: Regex.boolType, options: []){
            let string = self as NSString
            result = !regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return result
    }
    
    // Object 검사 : { 시작 or } 끝 찾기
    func isObject() -> Bool {
        let object = self.trimmingCharacters(in: .whitespaces)
        var result = false
        if let regex = try? NSRegularExpression(pattern: Regex.objectType, options: []){
            let string = object as NSString
            result = !regex.matches(in: object, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return result
    }
    
    // Array 검사 : [ 시작 or ] 끝 찾기
    func isArray() -> Bool {
        let array = self.trimmingCharacters(in: .whitespaces)
        var result = false
        if let regex = try? NSRegularExpression(pattern: Regex.arrayType, options: []){
            let string = array as NSString
            result = !regex.matches(in: array, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return result
    }
    
    func supportedArrayTypes() -> Bool {
        var result = false
        if let regex = try? NSRegularExpression(pattern: Regex.arrayPattern){
            let string = self as NSString
            let regexMatches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            if regexMatches.count > 0 { result = true }
        }
        return result
    }
    
    func supportedObjectTypes() -> Bool {        
        var result = false
        if let regex = try? NSRegularExpression(pattern: Regex.objectPatternBigObject){
            let string = self as NSString
            let regexMatches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            if regexMatches.count > 0 { result = true }
        }
        return result
    }
    
}
