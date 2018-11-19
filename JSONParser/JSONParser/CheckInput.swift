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
        let extractData : ExtractData = ExtractData()
        guard extractData.notSupportingArrayDataType(data: checkToArray).count == 0 else { return .notSupportingType }
        return .rightInput
    }
    
    // 입력 값이 객체인 경우 내부 검사
    private func checkObjectType(checkToObject : String) -> InputState {
        let extractData : ExtractData = ExtractData()
        guard extractData.notSupportingPropertyType(data: checkToObject).count == 0 else { return .notSupportingType }
        return .rightInput
    }
}
