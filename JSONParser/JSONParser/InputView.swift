//
//  InputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    // json 데이터 규격 (단순히 [{ : }] 형태인지만 확인
    private(set) static var jsonPattern = "\\[?(\\{\".+\":.+\\})+\\]?"
    
    // 사용자 입력 메뉴 출력 및 사용자 입력값 전처리.
    static func askFor(message: String) throws -> String? {
        // 요구 메시지 출력.
        print("\(message)", terminator: " ")
        // q 또는 quit 입력 시 종료.
        guard let inputLine = readLine(), inputLine != "q" && inputLine != "quit" else { return nil }
        // 문자열 처리를 쉽게 하기 위해 모든 공백 제거.
        let inputWithoutWhitespace = inputLine.filter { $0 != " " }
        // JSON 규격 여부 검사.
        guard try isJSONPattern(inputWithoutWhitespace) else { throw JSONParser.JsonError.invalidPattern }
        // 첫 글자가 대괄호이면서 두 번재 글자는 대괄호가 아닐 때, 가장 바깥쪽 대괄호가 있다고 판단.
        let firstCharacter = inputWithoutWhitespace.first
        let secondCharacter = inputWithoutWhitespace[inputWithoutWhitespace.index(after: inputWithoutWhitespace.startIndex)]
        if firstCharacter == "[" && secondCharacter != "[" {
            // 대괄호가 있으면 제거 후 반환.
            return removeSquareBracket(from: inputWithoutWhitespace)
        }else {
            // 대괄호가 없으면 그대로 반환.
            return inputWithoutWhitespace
        }
    }
    
    private static func removeSquareBracket(from data: String) -> String {
        // 가장 바깥쪽 대괄호 제거.
        let rangeWithoutSquareBracket = data.index(after: data.startIndex)..<data.index(before: data.endIndex)
        let dataWithoutSquareBracket = data[rangeWithoutSquareBracket]
        return String(dataWithoutSquareBracket)
    }
    
    // 사용자 입력 문자열이 JSON 규격인지 검사.
    private static func isJSONPattern(_ message: String) throws -> Bool {
        // json 데이터 규격에 맞는 경우, 1
        guard try message.splitPattern(by: jsonPattern).count > 0 else { return false }
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

