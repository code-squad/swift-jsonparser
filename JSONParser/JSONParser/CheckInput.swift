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

struct CheckInput {
    // 입력 값 검사하여 오류가 있는지 확인
    func checkUserInput(_ input: String) -> InputState {
        let typeChecker : CheckType = CheckType()
        if typeChecker.IsArrayType(input) { return checkArrayType(checkToArray: input) }
        else if typeChecker.IsObjectType(input) { return checkObjectType(checkToObject: input) }
        else { return .notArrayOrObjectType }
    }
    
    // 입력 값이 배열인 경우 내부 검사
    private func checkArrayType(checkToArray : String) -> InputState {
        let extractData : ExtractData = ExtractData()
        let typeChecker : CheckType = CheckType()
        let extractedData : [String] = extractData.inArrayAllDataType(data: checkToArray)
        for eachData in extractedData {
            guard let dataType = typeChecker.supportingType(eachData) else { return .notSupportingType }
            if dataType == .objectType { guard checkObjectType(checkToObject: eachData) == .rightInput else { return .notSupportingType } }
        }
        return .rightInput
    }
    
    // 입력 값이 객체인 경우 내부 검사
    private func checkObjectType(checkToObject : String) -> InputState {
        let extractData : ExtractData = ExtractData()
        let propertiesInObject : [String] = extractData.inObjectAllDataType(data: checkToObject)
        for eachProperty in propertiesInObject {
            guard extractData.objectDataExtract(objectData: eachProperty).count == 1 else { return .notSupportingType }
        }
        return .rightInput
    }
    
//    private func checkPropertyInObject(_ inputToProperty : String) -> Bool {
//        let extractData : ExtractData = ExtractData()
//        let propertiesInObject : [String] = extractData.inObjectAllDataType(data: inputToProperty)
//        for eachProperty in propertiesInObject {
//            guard extractData.objectDataExtract(objectData: eachProperty).count == 1 else { return false }
//        }
//        return true
//    }
}
