//
//  CheckInput.swift
//  JSONParser
//
//  Created by 윤동민 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    // 스트링의 첫번째 요소 리턴
    func getFirstElement() -> Character {
        let firstIndex = self.index(self.startIndex, offsetBy: 0)
        return self[firstIndex]
    }
    
    // 스트링의 마지막 요소 리턴
    func getLastElement() -> Character {
        let lastIndex = self.index(self.endIndex, offsetBy: -1)
        return self[lastIndex]
    }
}

struct GrammarChecker {
    // 입력 값 검사하여 오류가 있는지 확인
    func checkJSONForm(_ input: String) -> FormState {
        let extractData : ExtractData = ExtractData()
        guard extractData.searchRange(stringForRange: input) == NSRange(input.startIndex..., in: input) else { return .notSupportingType }
        return .rightForm
    }
    
    // Type을 검사하여 지원하는 타입인지 확인
    func checkSupportingTypeInSet(_ jsonType : String) -> InSetJSONType? {
        if IsStringType(jsonType) { return String() }
        else if IsBooleanType(jsonType) { return Bool() }
        else if IsNumberType(jsonType) { return Int() }
        else if IsObjectType(jsonType) { return Dictionary<String, InSetJSONType>()  }
        else if IsArrayType(jsonType) { return [InSetJSONType]() }
        else { return nil }
    }
    
    // 배열을 입력하였는지 검사
    func IsArrayType(_ input: String) -> Bool {
        guard input.getFirstElement() == "[" && input.getLastElement() == "]" else { return false }
        return true
    }
    
    // 객체 타입인지 검사
    func IsObjectType(_ input: String) -> Bool {
        guard input.getFirstElement() == "{" && input.getLastElement() == "}" else { return false }
        return true
    }
    
    // 스트링 타입인지 확인
    private func IsStringType(_ inputToCheck : String) -> Bool {
        let firstIndex = inputToCheck.index(inputToCheck.startIndex, offsetBy: 1)
        let lastIndex = inputToCheck.index(inputToCheck.endIndex, offsetBy: -1)
        guard inputToCheck[..<firstIndex] == "\"" else { return false }
        guard inputToCheck[lastIndex..<inputToCheck.endIndex] == "\"" else { return false }
        return true
    }
    
    // 숫자 타입인지 확인
    private func IsNumberType(_ inputToCheck : String) -> Bool {
        let numberSet = CharacterSet.decimalDigits
        for element in inputToCheck {
            guard String(element).rangeOfCharacter(from: numberSet) != nil else { return false }
        }
        return true
    }
    
    // Boolean 타입인지 확인
    private func IsBooleanType(_ inputToCheck : String) -> Bool {
        guard inputToCheck == "true" || inputToCheck == "false" else { return false }
        return true
    }
}
