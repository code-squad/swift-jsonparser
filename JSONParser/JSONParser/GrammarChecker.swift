//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    let input: String
    
    init(_ input: String) {
        self.input = input
    }
    
    //첫번째 시작하는 문자가 괄호인지 체크
    func isValidFirstString() -> Bool {
        return self.input.hasPrefix("[") || self.input.hasPrefix("{")
    }
    
    //마지막 문자가 괄호인지 체크
    func isValidLastString() -> Bool {
        return self.input.hasSuffix("]") || self.input.hasSuffix("}")
    }
    
    //객체 또는 배열이 중첩 인지 체크
    func isOverlappingObject() -> Bool {
        guard self.input.contains(": [") || self.input.contains(":[") || self.input.contains(": {") || self.input.contains(":{") else { return true }
        return false
    }
    
    //괄호 지운 데이터를 파라미터로 받아서 " 따옴표 체크, : 콜론체크
    func isValidFirstQuotation(_ quotationData: [String]) -> Bool {
        for data in quotationData {
            return data.hasPrefix("\"") && data.contains(":")
        }
        return false
    }
    
    //딕셔너리 키 문자 체크
    func isValidDictionaryKey(data: [String: Any], filter: String = "[a-z]") -> Bool {
        let regex = try! NSRegularExpression(pattern: filter, options: []) //options??
        for (key, _ ) in data {
            let list = regex.matches(in:key, options: [], range:NSRange.init(location: 0, length:key.count))
            if(list.count != key.count){
                return false
            }
        }
        return true
    }
    
    //딕셔너리 키 문자 또는 숫자 체크
    func isValidDictionaryValue(data: [String], filter: String = "[a-z||\\d]") -> Bool {
        let regex = try! NSRegularExpression(pattern: filter, options: []) //options??
        for value in data {
            let list = regex.matches(in: value, options: [], range:NSRange.init(location: 0, length: value.count))
            if(list.count != value.count){
                return false
            }
        }
        return true
    }
    
    
    
}


