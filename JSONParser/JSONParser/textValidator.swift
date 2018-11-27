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
    case invalidForm = "배열 또는 객체 형태로 입력하세요."
    case parsingError = "지원하지 않는 형식을 포함하고 있습니다."
    case noError
}

struct GrammarChecker {
    // 가능한 데이터 형태(배열, 객체)인지 확인
    private func hasBrackets(_ text: String) -> Bool {
        guard text.isArray || text.isObject else { return false }
        return true
    }
    
    // 콘솔로 받는 입력을 에러 처리
    public func textErrorCheck(of text: String) -> ErrorList {
        guard !text.isEmpty else { return .emptyInput }
        guard hasBrackets(text) else { return .invalidForm }
        guard JSONRegex().isParsable(text) else { return .parsingError }
        return .noError
    }
}
