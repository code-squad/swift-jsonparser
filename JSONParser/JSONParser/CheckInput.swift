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
    func checkUserInput(_ input: String) -> InputState {
        if IsArrayType(input) { return checkArrayType(checkToArray: input) }
        else if IsObjectType(input) { return checkObjectType(checkToObject: input) }
        else { return .notArrayOrObjectType }
    }
    
    // 배열을 입력하였는지 검사
    private func IsArrayType(_ input: String) -> Bool {
        guard input.getFirstElement() == "[" && input.getLastElement() == "]" else { return false }
        return true
    }
    
    // 객체 타입인지 검사
    private func IsObjectType(_ input: String) -> Bool {
        guard input.getFirstElement() == "{" && input.getLastElement() == "}" else { return false }
        return true
    }
    
    // 입력 값이 배열인 경우 내부 검사
    private func checkArrayType(checkToArray : String) -> InputState {
        let extractData = checkToArray.components(separatedBy: ["[", ",", "]"])
        guard IsSupportType(extractData) else { return .notSupportingType }
        return .rightInput
    }
    
    // 입력 값이 객체인 경우 내부 검사
    private func checkObjectType(checkToObject : String) -> InputState {
        let checkCorrectFormat = CheckType()
        guard checkCorrectFormat.IsObjectType(checkToObject) else { return .notCorrectObjectFormat }
        return .rightInput
    }
    
    // 지원하는 타입인지 확인
    private func IsSupportType(_ extractData: [String]) -> Bool {
        let checkType = CheckType()
        print(extractData)
        for index in 1..<extractData.count-1 { guard checkType.supportingType(extractData[index]) != nil else { return false } }
        return true
    }
}
