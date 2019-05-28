//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by jang gukjin on 28/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammerChecker {
    /// 딕셔너리의 key가 String이 아니면 에러를 반환하는 함수
    func distinctKeyType(key: String) throws {
        if key.first != Sign.doubleQuote || key.last != Sign.doubleQuote {
            throw ErrorMessage.wrongKey
        }
    }
    
    /// 딕셔너리의 value가 배열일떄 에러를 반환하는 함수
    func distinctInArray(value: String) throws {
        if value.first == Sign.frontSquareBracket, value.last == Sign.backSquareBracket {
            throw ErrorMessage.invalidFormat
        }
    }
    /// 입력받은 문자열의 문법 검사
    func grammarTest(jsonData: JsonParserable) throws -> JsonParserable{
        for (key,value) in jsonData.dictionaryJson {
            try distinctKeyType(key: key)
            try distinctInArray(value: value)
        }
        return jsonData
    }
}
