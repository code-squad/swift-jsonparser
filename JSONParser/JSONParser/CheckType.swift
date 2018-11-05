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
    func supportingType(_ data : String) -> SupportType {
        if IsStringType(data) { return .stringType }
        else if IsBooleanType(data) { return .booleanType }
        else if IsNumberType(data) { return .numberType }
        else { return .notSupporting }
    }
    
    // 스트링 타입인지 확인
    private func IsStringType(_ allData : String) -> Bool {
        let firstIndex = allData.index(allData.startIndex, offsetBy: 1)
        let lastIndex = allData.index(allData.endIndex, offsetBy: -1)
        guard allData[..<firstIndex] == "\"" else { return false }
        guard allData[lastIndex..<allData.endIndex] == "\"" else { return false }
        return true
    }
    
    // 숫자 타입인지 확인
    private func IsNumberType(_ allData : String) -> Bool {
        let numberSet = CharacterSet.decimalDigits
        for element in allData {
            guard String(element).rangeOfCharacter(from: numberSet) != nil else { return false }
        }
        return true
    }
    
    // Boolean 타입인지 확인
    private func IsBooleanType(_ allData : String) -> Bool {
        guard allData == "true" || allData == "false" else { return false }
        return true
    }
//    // 스트링 타입인지 확인
//    static func IsStringType(_ allData : String) -> Bool {
//        let firstIndex = allData.index(allData.startIndex, offsetBy: 1)
//        let lastIndex = allData.index(allData.endIndex, offsetBy: -1)
//        guard allData[..<firstIndex] == "\"" else { return false }
//        guard allData[lastIndex..<allData.endIndex] == "\"" else { return false }
//        return true
//    }
//
//    // 숫자 타입인지 확인
//    static func IsNumberType(_ allData : String) -> Bool {
//        let numberSet = CharacterSet.decimalDigits
//        for element in allData {
//            guard String(element).rangeOfCharacter(from: numberSet) != nil else { return false }
//        }
//        return true
//    }
//
//    // Boolean 타입인지 확인
//    static func IsBooleanType(_ allData : String) -> Bool {
//        guard allData == "true" || allData == "false" else { return false }
//        return true
//    }
}
