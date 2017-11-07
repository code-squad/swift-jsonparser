//
//  InputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct InputView {
    private(set) static var jsonPattern = "\\[{1}(.+[^\\[\\]\\s,]),*\\]{1}?"
    
    // 사용자 입력 메뉴 출력.
    static func askFor(message: String) throws -> String? {
        // 요구 메시지 출력.
        print("\(message)", terminator: " ")
        // 요구 메시지가 nil 인 경우, isNil 에러 처리.
        guard let inputLine = readLine(), try isJSONPattern(inputLine) else { return nil }
        // q 또는 quit 입력 시 종료.
        guard inputLine != "q" && inputLine != "quit" else { return nil }
        return inputLine
    }
    
    // 사용자 입력 문자열이 JSON 규격인지 검사.
    private static func isJSONPattern(_ message: String) throws -> Bool {
        guard try message.matches(by: jsonPattern).count > 0 else { return false }
        return true
    }
    
}
