//
//  CheckType.swift
//  JSONParser
//
//  Created by 윤동민 on 05/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct CheckType {
    // Type을 검사해서 지원하는 타입인지 enum 생성
    func supportingType(_ jsonType : String) -> SupportType? {
        if IsStringType(jsonType) { return .stringType }
        else if IsBooleanType(jsonType) { return .booleanType }
        else if IsNumberType(jsonType) { return .numberType }
        else if IsObjectType(jsonType) { return .objectType }
        else { return nil }
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
    
    //Objcect 타입인지 확인
    func IsObjectType(_ inputToCheck : String) -> Bool {
        var propertyToCheck : [String]
        guard inputToCheck.getFirstElement() == "{" && inputToCheck.getLastElement() == "}" else { return false }
        let objectProperty : [String] = inputToCheck.components(separatedBy: ["{", ",", "}"])
        guard objectProperty.count != 2 else { return false }
        for index in 1..<objectProperty.count-1 {
            propertyToCheck = objectProperty[index].split(separator: ":").map(String.init)
            guard IsStringType(propertyToCheck[0]) else { return false }
            guard IsStringType(propertyToCheck[1]) || IsNumberType(propertyToCheck[1]) || IsBooleanType(propertyToCheck[1]) else { return false }
        }
        return true
    }
}
