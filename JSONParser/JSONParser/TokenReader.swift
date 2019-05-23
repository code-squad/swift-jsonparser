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
    
    mutating func next() -> String? {
        var nextToken: String?
        let nextIndex = currentIndex + 1
        
        if (nextIndex < tokens.count) {
            nextToken = tokens[nextIndex]
            currentIndex += 1
        }
        return nextToken
    }
}
