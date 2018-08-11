//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    public static func checkException(to inputValue:String) throws {
    
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
        /*
         1. 공백제거
         2. [] 제거
         3. 첫번째 정규식에서 객체 | 문자 | 숫자 | 부울 개수 구함
         4-1. (1개 초과시) 두번째 정규식에서 3번의 개수 -1 만큼 반복되는 정규식과 ,(콤마)를 같이 세트로 묶고 마지막에 하나 더 정규식을 붙여줘서 형식이 맞으면 true 아니면 false
         4-2. (1개) 바로 정규식 표현 맞는 것으로 확인
         4-3. (0개) 값이 없으므로 false
         5. 기존의 문자열이랑 비교하여 일치하면 true 일치안하면 false
         */
        var array = self.trimmingCharacters(in: .whitespaces) // 1
        array.removeFirst() // 2
        array.removeLast()
        
        var patternCount = 0
        
        let objectRegex = "[\\s]?\\{[\\s]?\".*?\"[\\s]?:[\\s]?(\".*?\"|[0-9]|true|false)[\\s]?\\}[\\s]?"
        
        if let regex = try? NSRegularExpression(pattern: "(\(objectRegex)|(\\d)+|\".*?\"|true|false)", options: .caseInsensitive){
            let string = self as NSString
            
            let regexMatches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            if regexMatches.count > 1 {
                // 4-1
                patternCount = regexMatches.count
            }else if regexMatches.count == 1 {
                // 4-2 : 1개 값만 있는 정규식으로 맞습니다.
                return true
            }else {
                // 4-3 : 값이 없으므로 지원하지 않습니다.
                return false
            }
        }
        
        // 4-1 : 값이 1개 이상일때만 실행됩니다.
        if let regex = try? NSRegularExpression(pattern: "[\\s]?((\\{.*?\\}|(\\d)+|\".*?\"|true|false)[\\s]?,[\\s]?){\(patternCount-1)}[\\s]?(\\{.*?\\}|(\\d)+|\".*?\"|true|false)[\\s]?", options: .caseInsensitive){
            let string = array as NSString
            
            let regexMatches = regex.matches(in: array, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            for regexMatch in regexMatches {
                // 5
                if array == regexMatch {
                    return true
                }else {
                    return false
                }
            }
        }
        
        return false
    }
    
    func supportedObjectTypes() -> Bool {
        /*
         1. 공백제거
         2. {} 제거
         3. 첫번째 정규식에서 "string" : "value" 형식 개수 구함
         4-1. (1개 초과시) 두번째 정규식에서 3번의 개수 -1 만큼 반복되는 정규식과 ,(콤마)를 같이 세트로 묶고 마지막에 하나 더 정규식을 붙여줘서 형식이 맞으면 true 아니면 false
         4-2. (1개) 바로 정규식 표현 맞는 것으로 확인
         4-3. (0개) 값이 없으므로 false
         5. 기존의 문자열이랑 비교하여 일치하면 true 일치안하면 false
         */
        
        var object = self.trimmingCharacters(in: .whitespaces) // 1
        object.removeFirst() // 2
        object.removeLast()
        
        var patternCount = 0

        // 3
        if let regex = try? NSRegularExpression(pattern: "[\\s]?\".*?\"[\\s]?:[\\s]?(\".*?\"|[0-9]|true|false)[\\s]?", options: .caseInsensitive){
            let string = object as NSString

            let regexMatches = regex.matches(in: object, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            if regexMatches.count > 1 {
                // 4-1
                patternCount = regexMatches.count
            }else if regexMatches.count == 1 {
                // 4-2 : 1개 값만 있는 정규식으로 맞습니다.
                return true
            }else {
                // 4-3 : 값이 없으므로 지원하지 않습니다.
                return false
            }
            
        }
        
        // 4-1 : 값이 1개 이상일때만 실행됩니다.
        if let regex = try? NSRegularExpression(pattern: "([\\s]?\".*?\"[\\s]?:[\\s]?(\".*?\"|[0-9]|true|false)[\\s]?,[\\s]?){\(patternCount-1)}[\\s]?([\\s]?\".*?\"[\\s]?:[\\s]?(\".*?\"|[0-9]|true|false)[\\s]?)", options: .caseInsensitive){
            let string = object as NSString
            
            let regexMatches = regex.matches(in: object, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            for regexMatch in regexMatches {
                // 5
                if object == regexMatch {
                    return true
                }else {
                    return false
                }
            }
        }
        
        return false
    }
    
    
}
