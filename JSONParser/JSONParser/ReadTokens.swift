//
//  ReadTokens.swift
//  JSONParser
//
//  Created by JieunKim on 17/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation
struct ReadTokens {
    private var tokens = [String]()
    private var currentIndex: Int
    
    
    init(tokens: [String]) {
        self.tokens = tokens
        self.currentIndex = 0
    }
    
    mutating func getNextToken() throws -> String {
        let nextIndex = currentIndex + 1
        if nextIndex >= tokens.count {
            throw JSONError.TokensError
        }
        let nextToken = tokens[nextIndex]
        currentIndex = nextIndex
        return nextToken
    }
}
