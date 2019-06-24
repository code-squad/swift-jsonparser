//
//  PrettyFormatter.swift
//  JSONParser
//
//  Created by CHOMINJI on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class Formatter {
    var jsonString = ""
    private var indent = 0, depth = 0
    
    init() { }
    
    func prettyJSON(data: JSONValueType) -> String {
        serializeJSON(data: data)
        return jsonString
    }
    
    private func serializeJSON(data: JSONValueType) {
        switch data {
        case let object as Object:
            depth += 1
            serializeObject(data: object)
        case let array as JSONArray:
            depth += 1
            serializeArray(data: array)
        default:
            jsonString += "\(data)"
        }
    }
    
    private func serializeObject(data: Object) {
        jsonString += "{"
        jsonString += "\n"
        incAndWriteIndent()
        
        var first = true
        for (key, value) in data {
            if first {
                first = false
            } else {
                jsonString += ",\n"
                writeIndent()
            }
            serializeJSON(data: key)
            jsonString += ": "
            serializeJSON(data: value)
        }
        jsonString += "\n"
        
        if depth > 2 {
            writeIndent()
        }
        
        decAndWriteIndent()
        jsonString += "}"
    }
    
    private func serializeArray(data: JSONArray) {
        if depth > 2 {
            jsonString += "\n"
            incAndWriteIndent()
        }
        
        jsonString += "["
        var first = true
        for element in data {
            if first {
                first = false
            } else {
                jsonString += ", "
            }
            serializeJSON(data: element)
        }
        jsonString += "]"
        
        if depth > 2 {
            jsonString += "\n"
        }
    }
    
    private func incAndWriteIndent() {
        indent += 1
        writeIndent()
    }
    
    private func decAndWriteIndent() {
        indent -= 1
        writeIndent()
    }
    
    private func writeIndent() {
        let indentation = String.init(repeating: "\t", count: indent)
        jsonString += indentation
    }
}
