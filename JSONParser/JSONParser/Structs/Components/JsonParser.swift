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
    private var strategy: JsonParsingStrategy
    private var jsonValue: JsonValue
    
    init(tokens: Array<Token>) {
        self.tokens = tokens
        self.strategy =
            tokens[0] == Token.LeftBraket  ?
                JsonListParsingStrategy(): JsonObjectParsingStrategy()
        self.jsonValue = tokens[0] == Token.LeftBraket ?
            JsonList(): JsonObject()
    }
    
    mutating func parse() -> JsonValue {
        while(self.group()) {}
        return self.strategy.parse(tokens: self.tokens)
    }
    
    private mutating func group() -> Bool {
        guard let startIndex = self.tokens.firstIndex(of: Token.LeftBrace) else {
            return false
        }
        guard let endIndex = self.tokens.firstIndex(of: Token.RightBrace) else {
            return false
        }
        let object = Token.Object(Array(self.tokens[startIndex...endIndex]))
        self.tokens.removeSubrange(startIndex...endIndex)
        self.tokens.insert(object, at: startIndex)
        return true
    }
    
    private mutating func set(strategy: JsonParsingStrategy) {
        self.strategy = strategy
    }
    
}
