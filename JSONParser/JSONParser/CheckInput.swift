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
    // 유저의 입력을 검사
    func checkUserInput(_ input: String) -> InputState {
        let extractData = input.components(separatedBy: ["[", ",", "]"])
        guard IsArrayType(input) else { return .notArrayType }
        guard IsSupportType(extractData) else { return .notSupportingType }
        return .rightInput
    }
    
    // 배열을 입력하였는지 검사
    private func IsArrayType(_ input: String) -> Bool {
        guard input.getFirstElement() == "[" && input.getLastElement() == "]" else { return false }
        return true
    }
    
    // 지원하는 타입인지 확인
    private func IsSupportType(_ extractData: [String]) -> Bool {
        let checkType = CheckType()
        for index in 1..<extractData.count-1 {
            guard checkType.supportingType(extractData[index]) != nil else { return false }
        }
        return true
    }
}
