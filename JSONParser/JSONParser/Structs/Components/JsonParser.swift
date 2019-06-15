
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
    
    func parse(tokens: inout [Token]) -> JsonValue {
        tokens = tokens.filter {
            return ![.WhiteSpace,.Comma].contains($0)
        }
        if let context = tokens.first {
            self.selectStrategy(context: context)
        }
        return self.strategy!.parse(tokens: &tokens)
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
