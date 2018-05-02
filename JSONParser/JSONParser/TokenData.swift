//
//  TokenData.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 23..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct TokenData: TokenConvertible {
    
    private var tokens: [String]
    
    init(tokens: [String]) {
        self.tokens = tokens
    }
    
    func numberOfToken() -> Int {
        return self.tokens.count
    }
    
    func getToken(index: Int) -> String {
        return self.tokens[index]
    }
}
