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
    private let countingData : CountingData
    init (_ countingData: CountingData) {
        self.countingData = countingData
    }
     static func makeCountedTypeInstance (_ stringValues: Array<String>) -> CountingData {
        var numberValue = [Int]()
        var boolValue = [Bool]()
        var stringValue = [String]()
        for value in stringValues {
            if let IntegerValue = Int(value) { numberValue.append(IntegerValue) }
            if let booleanValue = Bool(value) { boolValue.append(booleanValue) }
            if value.contains("\"") { stringValue.append(value) }
        }
        let countedData = CountingData(countOfNumericValue: numberValue, countOfBooleanValue: boolValue, countOfStringValue: stringValue)
        return countedData
    }
}
