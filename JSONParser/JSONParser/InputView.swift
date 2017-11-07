//
//  InputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    // json 데이터 규격 (단순히 '['와 ']'로 감싸이고 ','로 요소가 구분된 형태인지만 확인)
    private(set) static var jsonPattern = "\\[{1}(.+[^\\[\\]\\s,]),*\\]{1}?"
    
    // 사용자 입력 메뉴 출력.
    static func askFor(message: String) throws -> String? {
        // 요구 메시지 출력.
        print("\(message)", terminator: " ")
        // q 또는 quit 입력 시 종료.
        guard let inputLine = readLine(), inputLine != "q" && inputLine != "quit" else { return nil }
        guard try isJSONPattern(inputLine) else { throw JSONParser.JsonError.invalidPattern }
        return inputLine
    }
    
    // 사용자 입력 문자열이 JSON 규격인지 검사.
    private static func isJSONPattern(_ message: String) throws -> Bool {
        // json 데이터 규격에 맞는 경우, 1
        guard try message.matches(by: jsonPattern).count > 0 else { return false }
        return true
    }
    
}

extension String {
    
    func matches(by rxPattern: String) throws -> [NSTextCheckingResult] {
        do {
            let expression = try NSRegularExpression(pattern: rxPattern)
            let matchedRange = expression.matches(in: self, options: .init(rawValue: 0), range: NSRange.init(self.startIndex..., in: self))
            return matchedRange
        } catch {
            throw error
        }
    }
    
}
