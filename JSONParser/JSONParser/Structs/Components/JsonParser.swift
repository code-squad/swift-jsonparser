//
//  MyListParser.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    private var tokens: Array<Token>
    var strategy: JsonParsingStrategy
    var jsonValue: JsonValue
    
    init(tokens: Array<Token>) {
        self.tokens = tokens
        self.strategy =
            tokens[0] == Token.LeftBraket ?
                JsonListParsingStrategy() : JsonObjectParsingStrategy()
        self.jsonValue = tokens[0] == Token.LeftBraket ?
                JsonList() : JsonObject()
    }
    
    mutating func parse() -> JsonValue {
        self.grouping()
        return self.strategy.parse(tokens: self.tokens)
    }
    
    mutating func grouping() {
        
    }
    
    private mutating func set(strategy: JsonParsingStrategy) {
        self.strategy = strategy
    }
    
}
