//
//  textValidator.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum ErrorList: String {
    case emptyInput = "입력값이 없습니다."
    case invalidForm = "배열 형태로 입력하세요."
    case parsingError = "지원하지 않는 데이터입니다."
    case noError
}

struct TextValidator {
    private let leftBracket:Character = "["
    private let rightBracket:Character = "]"
    
    private func hasBrackets(_ text: String) -> Bool {
        guard text.first == leftBracket else { return false }
        guard text.last == rightBracket else { return false }
        return true
    }
    
    private func hasPossibleData(_ text: String) -> Bool {
        let texts = text.removeQuotation.removeBracket.separateByComma
        
        for element in texts {
            guard element.isString || element.isNumeric || element.isBoolean else { return false }
        }
        return true
    }
    
    public func textErrorCheck(of text: String) -> ErrorList {
        guard hasBrackets(text) else { return .invalidForm }
        guard hasPossibleData(text) else { return .parsingError }
        guard !(text.isEmpty || text.removeBracket.isEmpty) else { return .emptyInput }
        return .noError
    }
}
