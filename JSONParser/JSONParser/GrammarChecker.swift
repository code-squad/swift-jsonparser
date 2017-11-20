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
        case dataOfNil = "데이터 변환에 오류가 있습니다."
    }
    
    // 중첩 불가 정규식.
    // 키 패턴. (문자열)
    private static let keyPattern = "(\"[^,:\\\"\\s]+?\")"
    // 기본형 값 패턴. 문자열|부울|숫자)
    private static let basicValuePattern = "(\"[^,:\\\"\\{\\[\\]\\}]+?\"|true|false|\\d+)"
    // 콤마포함 객체형 패턴. - "key" : value ,
    private static let objectValueWithComma = "(\\s*" + GrammarChecker.keyPattern + "\\s*:\\s*" + GrammarChecker.basicValuePattern + "\\s*,"
    // 콤마선택 객체형 패턴. (중간 데이터는 콤마 필수, 마지막 데이터는 선택) - {"key": value, "key": value, "key": value, ... }
    private static let objectValues = "(\\{" + GrammarChecker.objectValueWithComma + "\\s*)*" + GrammarChecker.objectValueWithComma + "?\\s*)\\})"
    // 콤마포함 배열형 패턴. - value,
    private static let arrayValueWithComma = "(\\s*" + GrammarChecker.basicValuePattern + "\\s*,"
    // 콤마선택 배열형 패턴. (중간 데이터는 콤마 필수, 마지막 데이터는 선택) - [ value, value, ... ]
    private static let arrayValues = "(\\[" + GrammarChecker.arrayValueWithComma + "\\s*)*" + GrammarChecker.arrayValueWithComma + "?\\s*)\\])"
    // 배열, 객체 내 삽입가능 값 패턴.
    static let jsonValuePattern = "(" + GrammarChecker.basicValuePattern+"|"+GrammarChecker.arrayValues+"|"+GrammarChecker.objectValues + ")"
    // 콤마포함 종합객체형 패턴. (중첩 객체값 가능.)
    private static let jsonValueWithComma = jsonValuePattern + "\\s*,"
    static let jsonObjectValueWithComma = GrammarChecker.keyPattern + "\\s*:\\s*" + GrammarChecker.jsonValueWithComma
    // 콤마선택 종합객체형 패턴. (중간 데이터는 콤마 필수, 마지막 데이터는 선택)
    private static let jsonObjectValues = "(\\s*" + GrammarChecker.jsonObjectValueWithComma + "\\s*)*(\\s*" + GrammarChecker.jsonObjectValueWithComma + "?\\s*)"
    // 콤마선택 종합배열형 패턴. (중간 데이터는 콤마 필수, 마지막 데이터는 선택)
    private static let jsonArrayValues = "(\\s*" + GrammarChecker.jsonValueWithComma + "\\s*)*(" + GrammarChecker.jsonValueWithComma + "?\\s*)"
    // 전체 배열 패턴. (1뎁스)
    private static let jsonArrayPattern = "(\\[" + GrammarChecker.jsonArrayValues + "\\])"
    // 전체 객체 패턴. (1뎁스)
    private static let jsonObjectPattern = "(\\{\\s*" + GrammarChecker.jsonObjectValues + "\\})"
    // 전체 json 규격.
    static let jsonPattern = GrammarChecker.jsonObjectPattern + "|" + GrammarChecker.jsonArrayPattern
    // 가장 바깥쪽 괄호만 제거한 패턴. parser의 맨 처음에 사용하기 위함.
    static let arrayDataWithoutBracket = "(?<=\\[).+(?=\\])"
    static let objectDataWithoutBracket  = "(?<=\\{).+(?=\\})"
    
    // 사용자 입력 문자열이 JSON 규격인지 검사.
    static func isJSONPattern(_ message: String) throws -> Bool {
        let checkedMessage = try message.splitPattern(by: GrammarChecker.jsonPattern)
        // 1개 이상 매칭된 경우, full match만 통과.
        guard checkedMessage.count > 0, checkedMessage[0] == message else {
            return false
        }
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
