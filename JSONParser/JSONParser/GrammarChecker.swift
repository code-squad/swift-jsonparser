//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 10..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    enum JsonError: String, Error {
        case invalidPattern = "지원하지 않는 형식을 포함하고 있습니다."
    }
    
    // 중첩 불가 정규식.
    static let jsonObjectPattern = "(^\\{(\\s*\"[^,:\\\"\\s]+?\"\\s*:\\s*(\"[^\\\"]+?\"|true|false|\\d+)\\s*,\\s*)*(\\s*\"[^,:\\\"\\s]+?\"\\s*:\\s*(\"[^\\\"]+?\"|true|false|\\d+)\\s*,?\\s*)\\})"
    static let objectValues = "\\s*(\"[^\\\"\\{\\[\\]\\}]+?\"|true|false|\\d+|\\[(\\s*(\"[^\\\"\\{\\[\\]\\}]+?\"|true|false|\\d+)\\s*,?\\s*)+\\]|\\{" + GrammarChecker.jsonObjectPattern + "+\\})\\s*,"
    static let jsonArrayPattern = "(^\\[(" + GrammarChecker.objectValues + "\\s*)*(" + GrammarChecker.objectValues + "?\\s*)\\])"
    static let jsonPattern = GrammarChecker.jsonObjectPattern + "|" + GrammarChecker.jsonArrayPattern
    // 가장 바깥쪽 괄호만 제거한 패턴.
    static let JSONArrayPattern = "((?<=\\[)(\\s*(\"[^\\\"\\{\\[\\]\\}]+?\"|true|false|\\d+|\\[(\\s*(\"[^\\\"\\{\\[\\]\\}]+?\"|true|false|\\d+)\\s*,?\\s*)+\\]|\\{(\\s*\"[^,:\\\"]+?\"\\s*:\\s*(\"[^\\\"]+?\"|true|false|\\d+)\\s*,?\\s*)+\\})\\s*,?\\s*)+(?=\\]))"
    // Object 데이터 패턴. - {"key": value, "key": value, ...}
    static let JSONObjectPattern  = "(?<=\\{)\\s?(\".+?\"\\s?\\:\\s?.+?)\\s?(?=\\})"
    // 재귀패턴으로 만들었으나, 안 먹히는 듯함.
    //static let jsonObjectPattern = "(\\{?\\s*\"[^,:\"\\\\s\\[\\]]+?\"\\s*:\\s*((\"[^\\\"]+?\"|true|false|\\d+|(\\[\\s*(?2)+?\\s*\\])|(?1)+?)\\s*,?)\\s*\\}?\\s*,?)"
    //static let jsonArrayPattern = "(\\[\\s*((\"[^\"\\]+?\"|true|false|\\d+)\\s*,?\\s*)*?\\s*\\])"
    // object의 key 패턴.
    static let objectKeyPattern = "((\"[^\"\\,]+?\")|true|false|\\d+)\\s*(?=:)"
    // object의 value 패턴. (딕셔너리 값. ':' 기준으로 나뉨)
    static let objectValuePattern = "(((?<=\\:)(\"[^\"\\,]+?\"))|true|false|\\d+)|\\[((\"[^\"\\,]+?\")|true|false|\\d+).+?\\]"
    // array의 value 패턴. (내부 [], {}을 1뎁스까지 매칭 가능.)
    static let arrayValuePattern = "((\"[^\"\\,]+?\")|true|false|\\d+|\\[(\\s*((\"[^\"\\,]+?\")|true|false|\\d+)+?\\s*,?\\s*)+?\\]|\\{(\\s*(\"[^\\\"\\s]+?\"\\s*:\\s*((\"[^\"\\,]+?\")|true|false|\\d+)+?)\\s*,?\\s*)+?\\})"
    static let innerArrayValuePattern = "(\"[^\"\\]+?\"|true|false|\\d+)"
    static let innerObjectValuePattern = "(?<=:)\\s*(\"[^\"\\]+?\"|true|false|\\d+)+?"
    
    // 사용자 입력 문자열이 JSON 규격인지 검사.
    static func isJSONPattern(_ message: String) throws -> Bool {
        let checkedMessage = try message.splitPattern(by: GrammarChecker.jsonPattern)
        guard checkedMessage.count > 0 else { return false }
        return true
    }
    
}

extension String {
    // 문자열을 특정 패턴에 따라 자른 후 문자열 배열 반환.
    func splitPattern(by rxPattern: String) throws -> [String] {
        do {
            let expression = try NSRegularExpression(pattern: rxPattern)
            let matchedRange = expression.matches(in: self, options: .init(rawValue: 0), range: NSRange.init(self.startIndex..., in: self))
            let matchedString = matchedRange.map({
                return String(self[Range($0.range, in: self)!])
            })
            return matchedString
        } catch {
            throw error
        }
    }
    
}
