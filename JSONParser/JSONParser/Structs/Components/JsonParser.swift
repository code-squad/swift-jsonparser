
//
//  MyListParser.swift
//  JSONParser
//
//  Created by 이동영 on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class JsonParser {
    static private var converter = TokenConverter()
    
    static func run(tokens: [Token], parsedIndex: Int = 0) -> ParsedResult {
        let tokens = tokens.filter {
            return ![.ws,.comma].contains($0)
        }
        let strategy = selectStrategy(context: tokens[parsedIndex])
        let result = strategy.parse(tokens: tokens, parsedIndex: parsedIndex)
        return result
    }
    
    static private func selectStrategy(context: Token) -> JsonParsingStrategy {
        if context == .leftBraket {
            return JsonListParsingStrategy(converter: JsonParser.converter)
        }
        return JsonObjectParsingStrategy(converter: JsonParser.converter)
    }
    
}
