//
//  Serialize.swift
//  JSONParser
//
//  Created by JH on 05/07/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

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


protocol Serializable {
    func serialized() -> String
}

extension Serializable {
    func serialized() -> String {
        return "\(self)"
    }
}

extension Array: Serializable where Element == JsonType {
    func serialized() -> String {
        var result = ""
        var isFirst = true
        result.append("[")
        self.forEach { element in
            if isFirst {
                isFirst = false
            } else {
                result.append(", ")
            }
            result.append(element.serialized())
        }
        result.append("]")
        
        return result
    }
}

extension Dictionary: Serializable where Key == String, Value == JsonType {
    func serialized() -> String {
        var result = ""
        var isFirst = true
        result.append("{")
        indentCount += 1
        self.forEach { (key, value) in
            if isFirst {
                isFirst = false
            } else {
                result.append(",")
            }
            result.append("\n")
            result.append(indent)
            result.append("\(key.serialized()): \(value.serialized())")
        }
        indentCount -= 1
        result.append("\n")
        result.append(indent)
        result.append("}")
        return result
    }
}

struct Serializer {
    //jsonValue 직렬화하는 메소드
    func serializeValue(_ jsonData: JsonType) -> String {
        return jsonData.serialized()
    }
}
