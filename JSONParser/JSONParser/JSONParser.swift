//
//  JSONParser.swift
//  JSONParser
//
//  Created by 윤동민 on 02/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // JSON 모든 데이터를 SWIFT 데이터 타입 배열에 저장
    func extractJSONtoSwift(dataToConvert : String) -> [SwiftType] {
        var jsonToSwift : [SwiftType] = []
        let jsonData : [String] = dataToConvert.components(separatedBy: ["[", ",", "]"])
        for index in 1..<jsonData.count-1 {
            guard let swiftType = extractData(jsonData[index]) else { return [] }
            jsonToSwift.append(swiftType)
        }
        return jsonToSwift
    }
    
    // JSON 데이터를 Swift 데이터로 바꾸어준다
    private func extractData(_ jsonData : String) -> SwiftType? {
        let checkType = CheckType()
        guard let jsonType = checkType.supportingType(jsonData) else { return nil }
        switch jsonType {
        case .stringType :
            return StringType(jsonData)
        case .booleanType :
            return BoolType(jsonData)
        case .numberType :
            return NumberType(jsonData)
        case .objectType :
            return ObjectType(jsonData)
        }
    }
    
    // 타입의 개수를 Count
    func countingType(_ swiftData : [SwiftType]) -> (Int, Int, Int, Int) {
        var typeCount : (totalCount : Int, stringCount : Int, boolCount : Int, numberCount : Int) = (swiftData.count, 0, 0, 0)
        for data in swiftData {
            if data is StringType { typeCount.stringCount += 1 }
            else if data is BoolType { typeCount.boolCount += 1 }
            else if data is NumberType { typeCount.numberCount += 1 }
        }
        return typeCount
    }
}
