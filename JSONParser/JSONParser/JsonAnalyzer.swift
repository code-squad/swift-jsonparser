//
//  JsonAnalyzer.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 입력값을 분석해서 타입 갯수 객체를 생성
struct Analyzer {
    // 각각의 타입 갯수를 세서 각각 타입갯수를 세서 튜플로 반환
    static func makeCountedTypeInstance (_ stringValues: Array<String>) -> CountingData {
        var countOfNumber = 0
        var countOfBool = 0
        var countOfString = 0
        for value in stringValues {
            if let _ = Int(value) { countOfNumber += 1 }
            if let _ = Bool(value) { countOfBool += 1 }
            if value.contains("\"") { countOfString += 1 }
        }
        let countedData = CountingData(countOfNumericValue: countOfNumber, countOfBooleanValue: countOfBool, countOfStringValue: countOfString)
        return countedData
    }
}
