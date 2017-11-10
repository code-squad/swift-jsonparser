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
    private(set) static var jsonPattern = "\\[?([\\[\\{]*\".+\":.+[\\}\\]]*,?)\\]?"
    
    // 사용자 입력값의 json 규격 체크 후 반환.
    static func askFor(message: String) throws -> String? {
        // 요구 메시지 출력.
        print("\(message)", terminator: " ")
        // q 또는 quit 입력 시 종료.
        guard let inputLine = readLine(), inputLine != "q" && inputLine != "quit" else { return nil }
        // JSON 규격 여부 검사.
        guard try isJSONPattern(inputLine) else { throw JSONParser.JsonError.invalidPattern }
        return inputLine
    }
    
    // 사용자 입력 문자열이 JSON 규격인지 검사.
    private static func isJSONPattern(_ message: String) throws -> Bool {
        // 패턴검사를 쉽게 하기 위해 모든 공백 제거.
        let messageWithoutWhitespace = message.filter { $0 != " " }
        // json 데이터 규격에 맞는 경우, 1
        guard try messageWithoutWhitespace.splitPattern(by: jsonPattern).count > 0 else { return false }
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

