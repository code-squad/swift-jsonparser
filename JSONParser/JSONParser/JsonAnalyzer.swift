//
//  JsonAnalyzer.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 입력값을 분석해서 타입 갯수 객체를 생성
struct Analyzer {
    enum ErrorMessage: String, Error {
        case ofNoSquareBracket = "입력값은 대괄호로 감싼형태여야 합니다."
        case ofNoComma = "입력값은 콤마로 구분되어야 합니다."
        case ofUnknown = "알려지지 않은 에러입니다."
    }
    
     func makeTypeCounting (_ stringValue: String) throws -> CountingData {
        guard let value = eliminateSquareBracket(stringValue) else { throw ErrorMessage.ofNoSquareBracket }
        guard let value2 = splitInputValueByComma(value) else { throw ErrorMessage.ofNoComma }
        let temp = makeType(value2)
        let temp2 = CountingData(countOfNumericValue: temp.0, countOfBooleanValue: temp.1, countOfStringValue: temp.2, countOfTotalValue: temp.3)
        return temp2
    }
    
    // 문자열의 대괄호를 제거
    private func eliminateSquareBracket (_ stringValue: String) -> String? {
        if stringValue.contains("[") && stringValue.contains("]") {
            let valueWithoutSquareBracket = stringValue.trimmingCharacters(in: ["[", "]"])
            return valueWithoutSquareBracket
        } else {
            return nil
        }
    }
    
    // 콤마 기준으로 배열로 정리
    private func splitInputValueByComma (_ input: String) -> Array<String>? {
        guard input.contains(",") else { return nil }
        let valueSplitedByComma = input.split(separator: ",").map(String.init)
        return valueSplitedByComma
    }
    
    // 각각의 타입 갯수를 세서 타입카운터 데이터 객체로 반환
    private func makeType (_ input: Array<String>) -> (Int, Int, Int, Int) {
        let countOfNum = input.flatMap() {Int($0)}.count
        let countOfBoolean = input.flatMap() {Bool($0)}.count
        let conutOfString = input.count - countOfNum - countOfBoolean
        return (countOfNum, countOfBoolean, conutOfString, input.count)
    }
    
    
}
