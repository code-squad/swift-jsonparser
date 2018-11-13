//
//  JSONParser.swift
//  JSONParser
//
//  Created by 윤동민 on 02/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // JSON -> Swift 타입으로 추출해 냄
    func extractJSONtoSwift(dataToConvert : String) -> [Any] {
        let checkType = CheckType()
        var jsonToSwift : [Any] = []
        let jsonData : [String] = dataToConvert.components(separatedBy: ["[", ",", "]"])
        for index in 1..<jsonData.count-1 {
            guard let jsonType = checkType.supportingType(jsonData[index]) else { return [] }
            switch jsonType {
            case .stringType :
                jsonToSwift.append(self.extractString(jsonData[index]))
            case .booleanType :
                jsonToSwift.append(self.extractBoolean(jsonData[index]))
            case .numberType :
                jsonToSwift.append(self.extractNumber(jsonData[index]))
            }
        }
        return jsonToSwift
    }
    
    // String으로 데이터를 추출
    private func extractString(_ data : String) -> String {
        var data = data
        data.remove(at: data.startIndex)
        data.remove(at: data.index(before: data.endIndex))
        return data
    }
    
    // Bool으로 데이터를 추출
    private func extractBoolean(_ data : String) -> Bool {
        guard data == "true" else { return false }
        return true
    }
    
    // Double으로 데이터를 추출
    private func extractNumber(_ data : String) -> Double {
        guard let convertedNumber = Double(data) else { return 0 }
        return convertedNumber
    }
    
    // 타입의 개수를 Count
    func countingType(_ swiftData : [Any]) -> (Int, Int, Int, Int) {
        var typeCount : (totalCount : Int, stringCount : Int, boolCount : Int, numberCount : Int) = (swiftData.count, 0, 0, 0)
        for data in swiftData {
            if data is String { typeCount.stringCount += 1 }
            else if data is Bool { typeCount.boolCount += 1 }
            else if data is Double { typeCount.numberCount += 1 }
        }
        return typeCount
    }
}
