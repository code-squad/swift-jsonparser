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
    }
    
     func makeTypeCounting (_ stringValue: String) throws -> CountingData {
        guard let eliminatedSquareBracket = eliminateSquareBracket(stringValue) else { throw ErrorMessage.ofNoSquareBracket }
        guard let splitedByComma = splitInputValueByComma(eliminatedSquareBracket) else { throw ErrorMessage.ofNoComma }
        let countedType = countType(splitedByComma)
        let countedInstans = CountingData(countOfNumericValue: countedType.0, countOfBooleanValue: countedType.1, countOfStringValue: countedType.2, countOfTotalValue: countedType.3)
        return countedInstans
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
    private func splitInputValueByComma (_ stringValue: String) -> Array<String>? {
        guard stringValue.contains(",") else { return nil }
        let valueSplitedByComma = stringValue.split(separator: ",").map(String.init)
        return valueSplitedByComma
    }
    
    // 각각의 타입 갯수를 세서 각각 타입갯수를 세서 튜플로 반환
    private func countType (_ stringValues: Array<String>) -> (Int, Int, Int, Int) {
        var countOfNumber = 0
        var countOfBool = 0
        var countOfString = 0
        for value in stringValues {
            if Int(value) != nil { countOfNumber += 1 }
            if Bool(value) != nil { countOfBool += 1 }
            if value.contains("\"") { countOfString += 1 }
        }
        return (countOfNumber, countOfBool, countOfString, stringValues.count)
    }
    
    
}
