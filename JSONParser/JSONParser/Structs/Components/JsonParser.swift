//
//  MyListParser.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    var tokens: Array<Token>
    var strategy: JsonParsingStrategy
    
    mutating func parse() -> JsonValue {
        self.nomalizeTokens()
        return self.strategy.parse(tokens: self.tokens)
    }
    
    mutating func nomalizeTokens() {
        
    }
    
}
