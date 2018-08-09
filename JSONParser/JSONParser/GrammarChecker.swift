//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    // [] or {} 쌍 검사
    public static func checkPair(to jsonData:String) -> Bool {
        let countPrefix1 = jsonData.contains("{")
        let countPrefix2 = jsonData.contains("[")
        let countSuffix1 = jsonData.contains("}")
        let countSuffix2 = jsonData.contains("]")
        guard countPrefix1 == countSuffix1 && countPrefix2 == countSuffix2 else { return false }
        return true
    }
    
    // [] or {} 패턴 검사
    public static func checkPattern(to jsonData:String) -> Bool {
        var data = jsonData
        
        data.removeFirst()
        data.removeLast()
        
        var before = ""
        /*
         [{{,}}]
         {[[,]]}
         {][[[]]}
         [}{]
         {[],[]}
         */
        for d in data {
            // 3 : } or ] 이게 처음부터 나오면 형태 잘못된 것 입니다.
            if before.isEmpty && (d == "}" || d == "]"){
                return false
            }
            // 1 : { or [ 이면 before에 값을 저장함
            if d == "{" || d == "[" {
                before = String(d)
            }
            // 2 : ] or } 이면 before에 동일한 형태가 있는지 확인
            if d == "}" || d == "]" {
                if d == "}" && before == "{" {
                    // Pass : before 초기화
                    before = ""
                }else if d == "]" && before == "[" {
                    // Pass : before 초기화
                    before = ""
                }else {
                    return false
                }
            }
        }
        return true
    }
}

extension String {
    func contains(_ find: String) -> Int{
        var count = 0
        for char in self {
            if find.contains(char) {
                count = count + 1
            }
        }
        return count
    }
    
    // 숫자 검사 : 있으면 return true OR 없으면 return false
    func isNumber() -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^[0-9]*$", options: []){
            let string = self as NSString
            let result = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
            guard result else { return true }
        }
        return false
    }
    
    // Bool 검사 : 맞으면 return true OR 아니면 return false
    func isBool() -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^true|false*$", options: []){
            let string = self as NSString
            let result = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
            guard result else { return true }
        }
        return false
    }
    
    // Object 검사 : { 시작 or } 끝 찾기
    func isObject() -> Bool {
        if let regex = try? NSRegularExpression(pattern: "[^{|}$]", options: []){
            let string = self as NSString
            let result = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
            guard result else { return true }
        }
        return false
    }
    
    // Array 검사 : [ 시작 or ] 끝 찾기
    func isArray() -> Bool {
        if let regex = try? NSRegularExpression(pattern: "[^[|]$]", options: []){
            let string = self as NSString
            let result = regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).isEmpty
            guard result else { return true }
        }
        return false
    }
    
}
