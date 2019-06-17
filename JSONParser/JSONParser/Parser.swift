//
//  Parser.swift
//  JSONParser
//
//  Created by 이진영 on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    static func parse(tokens: [String]) throws -> JsonType {
        if tokens.first == String(JsonElement.startOfArray), tokens.last == String(JsonElement.endOfArray) {
            return try parse(array: tokens)
        } else if tokens.first == String(JsonElement.startOfObject), tokens.last == String(JsonElement.endOfObject) {
            return try parse(object: tokens)
        } else {
            throw TypeError.unsupportedType
        }
    }
    
    private static func parse(array: [String]) throws -> JsonArray {
        var tokens = array
        tokens.removeFirst()
        tokens.removeLast()
        
        var unfinishedToken = ""
        var data: [JsonType] = []
        
        for token in tokens {
            if !unfinishedToken.isEmpty {
                unfinishedToken.append(token)
                
                try finish(unfinishedToken: &unfinishedToken, data: &data)
                
                continue
            }
            
            let pairResult = JsonElement.pair(value: token.first)
            
            if token.last != pairResult {
                if pairResult != nil {
                    unfinishedToken.append(token)
                    
                    continue
                }
            }
            
            if !(token == String(JsonElement.comma) || token == String(JsonElement.whitespace)) {
                data.append(try convert(token: token))
            }
        }
        
        return try JsonArray(array: data)
    }
    
    private static func parse(object: [String]) throws -> JsonObject {
        var tokens = object
        tokens.removeFirst()
        tokens.removeLast()
        
        var unfinishedToken = ""
        var data: [String : JsonType] = [:]
        
        return try JsonObject(object: data)
    }
    
    private static func finish(unfinishedToken: inout String, data: inout [JsonType]) throws {
        if JsonElement.pair(value: unfinishedToken.first) == unfinishedToken.last {
            data.append(try convert(token: unfinishedToken))
            unfinishedToken.removeAll()
        }
    }
    
    private static func convert(token: String) throws -> JsonType {
        if let result = Int(token) {
            return result
        }
        
        if token == JsonElement.true || token == JsonElement.false {
            return token == JsonElement.true ? true : false
        }
        
        if token.first == JsonElement.string, token.last == JsonElement.string {
            return token
        }
        
        if token.first == JsonElement.startOfObject, token.last == JsonElement.endOfObject {
            return token
        }
        
        throw ParseError.invalidValue
    }
}
