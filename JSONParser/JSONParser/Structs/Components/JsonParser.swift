
//
//  MyListParser.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class JsonParser {
    private var converter = TokenConverter()
    private var strategy: JsonParsingStrategy!
    
    func run(tokens: [Token], parsedIndex: Int = 0) -> ParsedResult {
        let tokens = tokens.filter {
            return ![.WhiteSpace,.Comma].contains($0)
        }
        self.selectStrategy(context: tokens[parsedIndex])
        let result = self.strategy!.parse(tokens: tokens, parsedIndex: parsedIndex)
        return result
    }
    
    private func selectStrategy(context: Token) {
        if context == .LeftBraket {
            set(strategy: JsonListParsingStrategy(converter: self.converter))
        }
        else {
            set(strategy: JsonObjectParsingStrategy(converter: self.converter))
        }
    }
    
    private func set(strategy: JsonParsingStrategy) {
        self.strategy = strategy
    }
    
}
