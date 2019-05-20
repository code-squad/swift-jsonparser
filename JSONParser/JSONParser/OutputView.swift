//
//  OutputView.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    func printMessage (_ message : (messages: [JsonTypeName: Int], typeName: JsonTypeName)) {
        var ment: String
        
        ment = "총 \(message.messages[JsonTypeName.total] ?? 0)개의 \(message.typeName.rawValue) 데이터 중에"
        
        for message in message.messages {
            if message.key != JsonTypeName.total {
                ment += " \(message.key.rawValue) \(message.value)개,"
            }
        }
        ment.removeLast()
        
        ment += "가 포함되어 있습니다."
        
        print(ment)
    }
    
    func printElements (_ elements: [JsonType], typeName: JsonTypeName) {
        var result: String = ""
        
        if typeName == JsonTypeName.object {
            result = objectToString(elements[0])
        }
        
        print(result)
    }
    
    private func objectToString (_ object: JsonType) -> String {
        var result: String = "{"
        var valueObject = ""
        
        if case let JsonType.object(object) = object {
            for (key, value) in object {
                valueObject = valueToString(value)
                result += "\n\t\(key) : \(valueObject),"
            }
        }
        
        result.removeLast()
        
        result += "\n}"
        
        return result
    }
    
    private func valueToString (_ json: JsonType) -> String {
        var valueOfString = "["
        var objectValue = ""
        switch json {
        case let .array(objectArray):
            for value in objectArray {
                objectValue = valueToString(value)
                valueOfString += "\((objectValue)), "
            }
            valueOfString.removeLast()
            valueOfString.removeLast()
            valueOfString += "]"
        case let .bool(objectBool):
            if objectBool {
                valueOfString = "true"
            } else {
                valueOfString = "false"
            }
        case let .int(objectInt): valueOfString = String(objectInt)
        case let .string(objectString): valueOfString = String(objectString)
        case .object(_): break
        }
        
        return valueOfString
    }
}
