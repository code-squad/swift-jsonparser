//
//  JSONToken.swift
//  JSONParser
//
//  Created by JieunKim on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONDataType {
    var typeDescription: String { get }
}

protocol JSONSerializable {
    func serialize() -> String
}

extension String: JSONDataType, JSONSerializable {
    var typeDescription: String {
        return "문자열"
    }
    
    func serialize() -> String {
        return "\"\(self)\""
    }
}

typealias Number = Double
extension Number: JSONDataType, JSONSerializable {
    var typeDescription: String {
        return "숫자"
    }
    
    func serialize() -> String {
        return "\(self)"
    }
    
}

extension Bool: JSONDataType, JSONSerializable {
    var typeDescription: String {
        return "부울"
    }
    
    func serialize() -> String {
        return "\(self)"
    }
}

protocol TypeCountable {
    var dataTypes: [String: Int] { get }
}

extension Array: JSONDataType, TypeCountable, JSONSerializable where Element == JSONDataType {
    
    var typeDescription: String {
        return "배열"
    }
    
    var dataTypes: [String: Int] {
        var dataTypes = [String: Int]()
        for item in self {
            dataTypes[item.typeDescription] = (dataTypes[item.typeDescription] ?? 0) + 1
        }
        return dataTypes
    }
    
    func serialize() -> String {
        var jsonString = ""
        var first = true
        let indent = String(repeating: " ", count: 2)
        
        jsonString.append("[")
        for value in self {
            if first {
                first = false
            } else {
                jsonString.append(",")
            }
            jsonString.append("\n")
            jsonString.append(indent)
            if let value = value as? JSONSerializable {
                jsonString.append(value.serialize().replacingOccurrences(of: "\n", with: "\n\(indent)"))
            }
        }
        jsonString.append("\n")
        jsonString.append("]")
        return jsonString
    }
}

typealias Object = Dictionary
extension Object: JSONDataType, TypeCountable, JSONSerializable where Key == String, Value == JSONDataType {
    var typeDescription: String {
        return "객체"
    }
    var dataTypes: [String: Int] {
        var dataTypes = [String: Int]()
        for item in self.values {
            dataTypes[item.typeDescription] = (dataTypes[item.typeDescription] ?? 0) + 1
        }
        return dataTypes
    }
    
    func serialize() -> String {
        var jsonString = ""
        var first = true
        let indent = String(repeating: " ", count: 2)
        
        jsonString.append("{")
        jsonString.append("\n")
        for (key, value) in self {
            if first {
                first = false
            } else {
                jsonString.append(",\n")
            }
            jsonString.append(indent)
            jsonString.append("\"\(key)\"")
            jsonString.append(":")
            jsonString.append(" ")
            if let value = value as? JSONSerializable {
                jsonString.append(value.serialize().replacingOccurrences(of: "\n", with: "\n\(indent)"))
            }
        }
        jsonString.append("\n")
        jsonString.append("}")
        return jsonString
    }
}
