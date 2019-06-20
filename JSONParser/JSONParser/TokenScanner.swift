//
//  TokenScanner.swift
//  JSONParser
//
//  Created by CHOMINJI on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol TokenScannable {
    mutating func nextToken() -> String?
}

struct TokenScanner: TokenScannable {
    private var tokens: [String]
    private var position = 0
    
    init(tokens: [String]) {
        self.tokens = tokens
    }
    
    mutating func nextToken() -> String? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
}
