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
    private var text: String
    private let leftBracket:Character = "["
    private let rightBracket:Character = "]"
    
    init(text: String) {
        self.text = text
    }
    
    private func hasBrackets() -> Bool {
        guard text.first == leftBracket else { return false }
        guard text.last == rightBracket else { return false }
        return true
    }
    
    private func hasPossibleData() -> Bool {
        let texts = text.removeBracket.separateByComma
        
        
        
        return true
    }
    
    public func textErrorCheck() -> ErrorList {
        
        guard hasBrackets() else { return .invalidForm }
        guard hasPossibleData() else { return .parsingError }
        guard !(text.isEmpty || text.removeBracket.isEmpty) else { return .emptyInput }
        return .noError
    }
}
