//
//  Checker.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 23..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct Checker {
    /// 문자열을 받아서 JSON 타입의 문자형인지 체크
    static func isLettersForJSON(letter : String) -> Bool {
        // 문자열의 첫번쨰와 마지막이 " 이면 참
        return letter[letter.startIndex] == JSON.letterWrapper && letter[letter.index(before:letter.endIndex)] == JSON.letterWrapper
    }
}
