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
        default:
            break
        }
    }
    
    func serializeString(_ value: String) {
        handler("\"")
        handler(value)
        handler("\"")
    }
}
