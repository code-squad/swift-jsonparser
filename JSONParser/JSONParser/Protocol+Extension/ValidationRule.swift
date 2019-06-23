//
//  ValidationRule.swift
//  JSONParser
//
//  Created by BLU on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol ValidationRule {
    func isValid(_ value: String) -> Bool
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
