//
//  ListToken.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 23..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum TokenType {
    case objectToken
    case listToken
}

struct Token: Tokenizable {
    
    private var tokens: [String]
    
    init(tokens: [String]) {
        self.tokens = tokens
    }
    
    mutating func add(token: String) {
        self.tokens.append(token)
    }
}
