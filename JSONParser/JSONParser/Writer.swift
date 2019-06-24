//
//  Writer.swift
//  JSONParser
//
//  Created by BLU on 25/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Writer {
    
    let handler: (String?) -> Void
    
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
}
