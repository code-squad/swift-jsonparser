//
//  Parser.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct Parser {
    private let tokens: [Token]
    private var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    private mutating func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
    
    mutating func parse() -> [Any] {
        var jsonArray = [Any]()
        
        while let token = getNextToken() {
            switch token {
            case .doubleQuotation:
                break
            case .string(let string):
                jsonArray.append(string)
            case .number(let number):
                jsonArray.append(number)
            case .comma:
                break
            case .bool(let bool):
                jsonArray.append(bool)
            }
        }
        return jsonArray
    }
}
