//
//  ObjectJSONData.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 24..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum DataType {
    case object
    case array
    
    var description: String {
        switch self {
        case .array:
            return "배열"
        case .object:
            return "객체"
        }
    }
}

struct ObjectJSONData: JSONData, JSONPrintable {
    
    private let dataType: DataType = .object
    private var jsonData: [String:JSONDataType] = [:]
    
    init(jsonData: JSONDataType) {
        if case .object(let value) = jsonData {
            self.jsonData = value
        }
    }
    
    func totalDataCountDescription() -> String {
        return "총 \(jsonData.count)개의 객체 데이터 중에 "
    }
    
    func totalDataTypeDescription() -> String {
        return self.dataType.description
    }
    
    func countDataDescription() -> String {
        var result: String = ""
        let (charactersCount, numberCount, booleanCount, objectCount) = calculateCountOfElements()
        
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
        
        result.removeLast()
        return result
    }
    
    private func calculateCountOfElements() -> (Int, Int, Int, Int) {
        var charactersCount = 0
        var numberCount = 0
        var booleanCount = 0
        var objectCount = 0
        
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
            default:
                break
            }
        }
        return (charactersCount, numberCount, booleanCount, objectCount)
    }
}
