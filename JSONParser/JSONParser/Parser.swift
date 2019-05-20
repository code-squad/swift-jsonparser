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
        var jsonArray = [JSONValue]()
        if isWrappedWithBrackets(using: tokens) {
            jsonArray = try createJSONArray(using: tokens)
        }
        if jsonArray.isEmpty {
            throw JSONError.invalidFormatToParse
        }
        return jsonArray
    }
    
    static private func isWrappedWithBrackets(using tokens: [String]) -> Bool {
        return tokens[0] == JSONSymbols.openBracket
               && tokens[tokens.count-1] == JSONSymbols.closedBracket
    }
    
    static private func createJSONArray(using tokens: [String]) throws -> [JSONValue] {
        var jsonArray = Array<JSONValue>()
        for token in tokens {
            if (token == JSONSymbols.openBracket || token == JSONSymbols.closedBracket || token == JSONSymbols.comma) {
                continue
            }
            let parsedValue = try convertIntoJSONValue(using: token)
            jsonArray.append(parsedValue)
        }
        return jsonArray
    }
    
    static private func convertIntoJSONValue(using token: String) throws -> JSONValue {
        let convertedValue = try JSONValueFactory.make(token: token)
        return convertedValue
    }
    
}
