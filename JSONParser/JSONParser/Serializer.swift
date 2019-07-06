//
//  Serialize.swift
//  JSONParser
//
//  Created by JH on 05/07/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Serializer {
    //indentCount에따라 공백이 추가되는 코드
    private var indentCount = 0
    private func makeIndent(count: Int) -> String {
        var result = ""
        for _ in 0 ..< count {
            result.append("    ")
        }
        return result
    }
    private var indent: String {
        return makeIndent(count: indentCount)
    }
    
    //jsonValue 직렬화하는 메소드
    mutating func serializeValue(_ jsonData: JsonType) -> String {
        switch jsonData {
        case let object as [String: JsonType]:
            return serializeObject(object)
        case let array as [JsonType]:
            return serializeArray(array)
        default:
            return ("\(jsonData)")
        }
    }
    //jsonType배열 직렬화하는 메소드
    mutating func serializeArray(_ array: [JsonType]) -> String {
        var result = ""
        var isFirst = true
        result.append("[")
        indentCount += 1
        array.forEach { element in
            if isFirst {
                isFirst = false
            } else {
                result.append(",")
            }
            result.append("\n")
            result.append(indent)
            result.append(serializeValue(element))
        }
        indentCount -= 1
        result.append("\n")
        result.append(indent)
        result.append("]")
        return result
    }
    //jsonType오브젝트 직렬화하는 메소드
    mutating func serializeObject(_ object: [String: JsonType]) -> String {
        var result = ""
        var isFirst = true
        result.append("{")
        indentCount += 1
        object.forEach { (key, value) in
            if isFirst {
                isFirst = false
            } else {
                result.append(",")
            }
            result.append("\n")
            result.append(indent)
            result.append("\(key): \(serializeValue(value))")
        }
        indentCount -= 1
        result.append("\n")
        result.append(indent)
        result.append("}")
        return result
    }

    
    
}
