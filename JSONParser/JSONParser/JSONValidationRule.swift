//
//  JSONValidationRule.swift
//  JSONParser
//
//  Created by BLU on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONValidationRule: ValidationRule {
    func isValid(_ value: String) -> Bool {
        return value =~ Regex.jsonObject || value =~ Regex.jsonArray
    }
}

extension String {
    func matches(_ pattern: String) -> Bool {
        return self.range(of: pattern, options: .regularExpression) != nil
    }
}

precedencegroup RegexPrecedence {
    higherThan: LogicalConjunctionPrecedence
}
/// 정규식 패턴에 매치하는 사용자 정의 연산자
infix operator =~: RegexPrecedence
/// - Parameters:
///   - string: 입력할 문자열
///   - pattern: 정규식 문자열
/// - Returns: 정규식에 일치 여부에 따라 true or false
func =~ (string: String, pattern: String) -> Bool {
    return string.matches(pattern)
}
