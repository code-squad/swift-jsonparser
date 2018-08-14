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
    /*
     TIP
     대괄호 \\[ or \\]
     따옴표 \"
     모든문자(특수문자,공백포함) .*?
     패턴 중간 공백 제외하고 체크 [?!\\s]
     
     문자 or 숫자 or 부울 검사 : (\".*?\"|true|false|[0-9])
     띄어쓰기 \\s
     띄어쓰기가 있거나 없거나 [\\s]?
     숫자 (\\d)+
     */
    
    // 숫자 검사 : 있으면 return true OR 없으면 return false
    func isNumber() -> Bool {
        var result = false
        if let regex = try? NSRegularExpression(pattern: "^[0-9]*$", options: []){
            let string = self as NSString
            result = !regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return result
    }
    
    // Bool 검사 : 맞으면 return true OR 아니면 return false
    func isBool() -> Bool {
        var result = false
        if let regex = try? NSRegularExpression(pattern: "^true|false*$", options: []){
            let string = self as NSString
            result = !regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return result
    }
    
    // Object 검사 : { 시작 or } 끝 찾기
    func isObject() -> Bool {
        let object = self.trimmingCharacters(in: .whitespaces)
        var result = false
        if let regex = try? NSRegularExpression(pattern: "^\\{.*?\\}$", options: []){
            let string = object as NSString
            result = !regex.matches(in: object, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return result
    }
    
    // Array 검사 : [ 시작 or ] 끝 찾기
    func isArray() -> Bool {
        let array = self.trimmingCharacters(in: .whitespaces)
        var result = false
        if let regex = try? NSRegularExpression(pattern: "^\\[.*?\\]$", options: []){
            let string = array as NSString
            result = !regex.matches(in: array, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
        }
        return result
    }
    
    func supportedArrayTypes() -> Bool {
        var result = false
        
        let stringWithSpecial = "\".*?\""
        let string = "\"[\\w]+\""
        let int = "[0-9]+"
        let boolTrue = "true"
        let boolFalse = "false"
        let object = "\\{[\\s]?\(stringWithSpecial)[\\s]?:[\\s]?(\(stringWithSpecial)|\(int)|\(boolTrue)|\(boolFalse))[\\s]?\\}"
        let arrayValue = "\\[.*?\\]"
        let allValueOfArray = "(\(string)|\(int)|\(boolTrue)|\(boolFalse)|\(object)|\(arrayValue))"
        let arrayPattern = "[\\s]?\\[[\\s]?([\\s]?\(allValueOfArray)\\,?[\\s]?)+[\\s]?\\][\\s]?"
        
        
        // 4-1 : 값이 1개 이상일때만 실행됩니다.
        if let regex = try? NSRegularExpression(pattern: arrayPattern){
            let string = self as NSString
            
            let regexMatches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            if regexMatches.count > 0 {
                result = true
            }
            
        }
        
        return result
    }
    
    func supportedObjectTypes() -> Bool {        
        var result = false
        
        let string = "\"[\\w]+\""
        let allValueOfObject = ".*?"
        let objectPattern = "[\\s]?\\{[\\s]?\(string)[\\s]?:([\\s]?\(allValueOfObject)\\,?[\\s]?)+[\\s]?\\}[\\s]?"
        
        if let regex = try? NSRegularExpression(pattern: objectPattern){
            let string = self as NSString
            
            let regexMatches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }

            if regexMatches.count > 0 {
                result = true
            }
            
        }
        
        return result
    }
    
    
}
