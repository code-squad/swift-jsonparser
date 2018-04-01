//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    private let inputJSONData: String
    
    init(_ inputJSONData: String) {
        self.inputJSONData = inputJSONData
    }
    
    //첫번째 시작하는 문자가 괄호인지 체크
    private func isValidFirstString() -> Bool {
        return self.inputJSONData.hasPrefix("[") || self.inputJSONData.hasPrefix("{")
    }
    
    //마지막 문자가 괄호인지 체크
    private func isValidLastString() -> Bool {
        return self.inputJSONData.hasSuffix("]") || self.inputJSONData.hasSuffix("}")
    }
    
    //객체 또는 배열이 중첩 인지 체크
    func isOverlappingObject() -> Bool {
        if isValidFirstString() && isValidLastString() {
            let regex = try! NSRegularExpression(pattern: "[\\{|\\[\\\"a-z\\\"\\:|\\ \\[|\\{\\\"a-z\\\"\\:\\d|a-z|\\]|\\}|\\]|\\}]", options: [])
            let matches = regex.matches(in: self.inputJSONData, options: [], range: NSRange(location: 0, length: self.inputJSONData.count))
            if matches.count == self.inputJSONData.count {
                return false
            }
            return true
        }
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
    func isValidDictionaryKey(data: [String: Any]) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[a-z|A-Z]", options: [])
        for (key, _ ) in data {
            let list = regex.matches(in:key, options: [], range:NSRange.init(location: 0, length:key.count))
            if(list.count != key.count){
                return false
            }
        }
        return true
    }
    
    
}

