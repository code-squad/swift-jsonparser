//
//  CheckError.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct CheckError {
    private let validCharacters = CharacterSet.init(charactersIn: " ,[]truefalse\"{}:").union(CharacterSet.alphanumerics)
    
    func isValid (_ userInput : String) -> Bool {
        guard isData(userInput) == true else { return false }
        guard isValidCharacters(userInput) == true else { return false }
        return true
    }
    
    private func isData (_ input : String) -> Bool {
        if input.first == "[" && input.last == "]" { return true }
        if input.first == "{" && input.last == "}" { return true }
        print("배열이나 객체의 형태가 아닙니다. 다시 입력해주세요.")
        return false
    }
    
    private func isValidCharacters (_ userInput : String) -> Bool {
        let userCharacters = userInput.components(separatedBy: validCharacters).filter { $0 != "" }
        if userCharacters.count == 0 {
            return true
        }
        print("지원하지 않는 규격이 들어 있습니다. 다시 입력해주세요.")
        return false
    }
}
