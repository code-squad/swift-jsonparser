//
//  TokenReader.swift
//  JSONParser
//
//  Created by Daheen Lee on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TokenReader {
    private var currentIndex: Int
    private var tokens: [String]
    
    init(tokens: [String]) {
        self.tokens = tokens
        self.currentIndex = -1
    }
    
    mutating func next() throws -> String {
        let nextIndex = currentIndex + 1
        if nextIndex >= tokens.count {
            throw JSONError.hasNoNextToken
        }
        let nextToken = tokens[nextIndex]
        currentIndex = nextIndex
        return nextToken
    }
}
