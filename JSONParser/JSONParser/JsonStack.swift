//
//  JsonStack.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 29..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonStack {
    var stack = [JsonScanner.regex]()
    
    mutating func push(data: JsonScanner.regex) {
        stack.append(data)
    }
    
    mutating func pop() throws -> JsonScanner.regex {
        guard stack.isEmpty else {
            return stack.popLast()!
        }
        throw JsonScanner.JsonError.invalidJsonPattern
    }
    
}
