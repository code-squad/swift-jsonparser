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
    static func isInputable(input: String) -> Bool {
        let characterCanBeEntered = CharacterSet(charactersIn: "[ 01234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,\"]")
        let inputCheck = input.trimmingCharacters(in: characterCanBeEntered)
        guard inputCheck.isEmpty else {
            return false
        }
        return true
    }
}
