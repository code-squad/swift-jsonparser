//
//  CheckInput.swift
//  JSONParser
//
//  Created by JINA on 09/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum ErrorMessage: Error {
    case reEntered
    var description: String {
        switch(self) {
        case .reEntered: return "입력 형식을 확인 하세요."
        }
    }
}

struct CheckInput {
    // 사용자의 입력 문자열 확인
    private static func isInputable(_ input: String) -> Bool {
        let characterCanBeEntered = CharacterSet(charactersIn: "[ 01234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,\"]")
        let inputCheck = input.trimmingCharacters(in: characterCanBeEntered)
        guard inputCheck.isEmpty else {
            return false
        }
        return true
    }
    
    // 사용자의 입력 양 끝에 [] 확인
    private static func hasParentheses(_ input: String) -> Bool {
        return input.contains("[") && input.contains("]")
    }
    
    // 사용자의 입력이 유효한지 확인
    static func validInput(userInput: String) -> Bool {
        return isInputable(userInput) && hasParentheses(userInput)
    }
    
}
