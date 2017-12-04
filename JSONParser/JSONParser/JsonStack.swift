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
    var index = 0
    
    mutating func push(tokenData: Token) {
        stack.append(tokenData)
        index += 1
    }
    
    mutating func pop() throws -> Token {
        guard stack.isEmpty else {
            index -= 1
            return stack.popLast()!
        }
        throw JsonScanner.JsonError.invalidJsonPattern
    }
    
    func peek() -> Token {
        return stack[index-1]
    }
    
}
