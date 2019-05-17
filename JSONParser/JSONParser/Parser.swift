//
//  Parser.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    static func parse(_ tokens: [String]) throws -> [JSONValue] {
        if isWrappedWithBrackets(using: tokens) {
            
            let innerRange = 1...tokens.count - 2
            let innerValues = Array(tokens[innerRange])
            return try parseIntoJSONValues(using: innerValues)
        }
        
        throw ParserError.invalidFormatToParse
        
    }
    
    static private func isWrappedWithBrackets(using tokens: [String]) -> Bool {
        return tokens[0] == JSONSymbols.openBracket
            && tokens[tokens.count-1] == JSONSymbols.closedBracket
    }
    
    static private func parseIntoJSONValues(using tokens: [String]) throws -> [JSONValue] {
        var values: [JSONValue] = []
        
        for token in tokens {
            let value = try JSONValueFactory.make(token: token)
            values.append(value)
        }
        
        if values.isEmpty { throw ParserError.impossibleToParse }
        
        return values
    }
    
}
