//
//  Parser.swift
//  JSONParser
//
//  Created by 이진영 on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    static func parse(tokens: [String]) throws -> JsonArray {
        var parseResult: [JsonType] = []
        
        for token in tokens {
            parseResult.append(try parse(token: token))
        }
        
        return JsonArray(array: parseResult)
    }
    
    private static func parse(token: String) throws -> JsonType {
        if let result = Int(token) {
            return result
        }
        
        if token == "true" {
            return true
        }
        
        if token == "false" {
            return false
        }
        
        if token.first == TokenElement.string.rawValue, token.last == TokenElement.string.rawValue {
            return token
        }
        
        throw ParseError.invalidValue
    }
}
