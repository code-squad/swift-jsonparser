//
//  JSONValueContainable.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 6..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

protocol TypeCountable {
    var dataTypes: [String: Int] { get }
}

extension Array: JSONValue, TypeCountable, JSONSerializable where Element == JSONValue {
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

extension Dictionary: JSONValue, TypeCountable, JSONSerializable where Key == String, Value == JSONValue {
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
