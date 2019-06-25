//
//  Writer.swift
//  JSONParser
//
//  Created by BLU on 25/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Writer {
    
    private let indentAmount = 2
    private var indent = 0
    private let handler: (String?) -> Void
    
    init(handler: @escaping (String?) -> Void) {
        self.handler = handler
    }
    
    mutating func serializeJSON(_ jsonValue: JSONValue) {
        switch jsonValue {
        case let string as String:
            serializeString(string)
            break
        case let bool as Bool:
            handler(String(bool))
            break
        case let number as Int:
            handler(String(number))
            break
        case let array as [JSONValue]:
            serializeArray(array)
            break
        case let object as [String: JSONValue]:
            serializeObject(object)
        default:
            break
        }
    }
    
    private func serializeString(_ value: String) {
        handler("\"")
        handler(value)
        handler("\"")
    }
    
    private mutating func serializeArray(_ array: [JSONValue]) {
        handler("[")
        
        var first = true
        for value in array {
            if first {
                first = false
            } else {
                handler(", ")
            }
            serializeJSON(value)
        }
        handler("]")
    }
    
    private mutating func serializeObject(_ object: [String: JSONValue]) {
        handler("{")
        var first = true
        handler("\n")
        incAndWriteIndent()
        for (key, value) in object {
            if first {
                first = false
            } else {
                handler(",\n")
                writeIndent()
            }
            serializeString(key)
            handler(":")
            handler(" ")
            serializeJSON(value)
        }
        handler("\n")
        decAndWriteIndent()
        handler("}")
    }
    
    private mutating func incAndWriteIndent() {
        indent += indentAmount
        writeIndent()
    }
    
    private mutating func decAndWriteIndent() {
        indent -= indentAmount
        writeIndent()
    }
    
    private func writeIndent() {
        for _ in 0..<indent {
            handler(" ")
        }
    }
}
