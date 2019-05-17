//
//  Parser.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    static func parse(_ tokens: [String]) -> [JSONValue] {
        
        var values: [JSONValue] = []
        
        if isWrappedWithBrackets(using: tokens) {
            let tokensWithoutBracket = tokens.filter() { token in
                token != JSONSymbols.openBracket && token != JSONSymbols.closedBracket }
            
            values = parseIntoJSONValues(using: tokensWithoutBracket)
        }
        
        return values
        
    }
    
    static private func isWrappedWithBrackets(using tokens: [String]) -> Bool {
        return tokens[0] == JSONSymbols.openBracket
            && tokens[tokens.count-1] == JSONSymbols.closedBracket
    }
    
    static private func parseIntoJSONValues(using tokens: [String]) -> [JSONValue] {
        var values: [JSONValue] = []
        
        for token in tokens {
            let value = JSONValueFactory.make(token: token)
            values.append(value)
        }
        return values
    }
    
}


