//
//  JSONParser.swift
//  JSONUnitTest
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation
struct JSONParser {
    static func parse(_ tokens:[Token]) {
        var numberCount = 0
        var stringCount = 0
        var boolCount = 0
        for token in tokens{
            switch token {
            case .string:
                stringCount += 1
            case .bool:
                boolCount += 1
            case .number:
                numberCount += 1
            }
        }
        print("총 \(tokens.count)개의 데이터 중에 ", terminator:"")
        if numberCount != 0 { print("숫자 \(numberCount)개 ", terminator:"") }
        if stringCount != 0 { print("문자열 \(stringCount)개 ", terminator:"") }
        if boolCount != 0 { print("부울 \(boolCount)개 ", terminator: "") }
        print("가 포함돼 있습니다.")
        print("-----------------------------------")
    }
}
