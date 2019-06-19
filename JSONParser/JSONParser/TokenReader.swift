//
//  TokenReader.swift
//  JSONParser
//
//  Created by BLU on 19/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TokenReader: Reader {
    
    private let tokens: [Token]
    private(set) var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    mutating func peek() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        return tokens[position]
    }
    
    mutating func advance() {
        position = position + 1
    }
}
