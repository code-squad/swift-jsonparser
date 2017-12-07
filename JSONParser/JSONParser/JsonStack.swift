//
//  JsonStack.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 29..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JsonStack {
    var stack = [Token]()
    var size = 0
    
    mutating func push(tokenData: Token) {
        stack.append(tokenData)
        size += 1
    }
    
    mutating func pop() throws -> Token {
        guard stack.isEmpty else {
            size -= 1
            return stack.popLast()!
        }
        throw JsonScanner.JsonError.invalidJsonPattern
    }
    
    func peek() throws -> Token {
        return stack[size - 1]
    }
    
}
