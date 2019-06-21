//
//  ReadTokens.swift
//  JSONParser
//
//  Created by JieunKim on 17/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation
struct TokenReader {
    private var tokens: [String]
    private var currentIndex: Int = -1
    
    init(tokens: [String], currentIndex: Int = -1) {
        self.tokens = tokens
        self.currentIndex = currentIndex
    }
    
    mutating func getNextToken() throws -> String {
        let nextIndex = currentIndex + 1
        if nextIndex >= tokens.count {
            throw JSONError.TokensError
        }
        let nextToken = tokens[nextIndex]
        currentIndex = nextIndex
        if nextToken == String(Token.nameSeparator) {
            return try getNextToken()
        }
        return nextToken
    }
}
