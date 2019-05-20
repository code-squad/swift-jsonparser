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
        } else {
            result = arrayToString(elements)
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
        var valueString = "["
        
        switch json {
        case let .array(array): valueString += arrayInArrayToString(array)
        case let .bool(bool):
            if bool {
                valueString = "true"
            } else {
                valueString = "false"
            }
        case let .int(int): valueString = String(int)
        case let .string(string): valueString = String(string)
        case .object(_):
            valueString = objectToString(json)
        }
        
        return valueString
    }
    
    private func arrayToString (_ array: [JsonType]) -> String {
        var result: String = "["
        
        for element in array {
            result += valueToString(element)
            result += ",\n\t"
        }
        result.removeLast()
        result.removeLast()
        result.removeLast()
        
        result += "\n]"
        
        return result
    }
    
    private func arrayInArrayToString (_ array: [JsonType]) -> String {
        var valueArray = ""
        var valueString = ""
        
        for value in array {
            valueArray = valueToString(value)
            valueString += "\((valueArray)), "
        }
        valueString.removeLast()
        valueString.removeLast()
        valueString += "]"
        
        return valueString
    }
}
