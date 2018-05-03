//
//  ObjectJSONData.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 24..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ObjectJSONData: JSONData, JSONPrintable {
    
    private var jsonData: [String:JSONDataValue] = [:]
    var jsonFormatter: JSONFormatter = JSONFormatter()
    
    init(jsonData: JSONDataValue) {
        if case .object(let value) = jsonData {
            self.jsonData = value
        }
    }
    
    func totalDataCountDescription() -> String {
        return "총 \(jsonData.count)개의 객체 데이터 중에 "
    }
    
    func countDataDescription() -> String {
        var result: String = ""
        let (charactersCount, numberCount, booleanCount, objectCount, arrayCount) = calculateCountOfElements()
        
        if charactersCount > 0 {
            result += "문자열 \(charactersCount)개,"
        }
        
        if numberCount > 0 {
            result += "숫자 \(numberCount)개,"
        }
        
        if booleanCount > 0 {
            result += "부울 \(booleanCount)개,"
        }
        
        if objectCount > 0 {
            result += "객체 \(objectCount)개,"
        }
        
        if arrayCount > 0 {
            result += "배열 \(arrayCount)개,"
        }
        result.removeLast()
        return result
    }
    
    private func calculateCountOfElements() -> (Int, Int, Int, Int, Int) {
        var charactersCount = 0
        var numberCount = 0
        var booleanCount = 0
        var objectCount = 0
        var arrayCount = 0
        
        for element in self.jsonData.values {
            switch element {
            case .characters:
                charactersCount += 1
            case .number:
                numberCount += 1
            case .boolean:
                booleanCount += 1
            case .object:
                objectCount += 1
            case .array:
                arrayCount += 1
            }
        }
        return (charactersCount, numberCount, booleanCount, objectCount, arrayCount)
    }
    
    func validateJSONData() -> String {
        return self.jsonFormatter.makeJSONObjectFormat(indent: 1, self.jsonData)
    }
}
