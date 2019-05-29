//
//  Lexer.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct Lexer {
    let input: String
    var position: String.Index
    
    init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    mutating func advance() {
        position = input.index(after: position)
    }
}
