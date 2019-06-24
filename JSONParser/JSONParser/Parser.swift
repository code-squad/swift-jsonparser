//
//  Parser.swift
//  JSONParser
//
//  Created by 이진영 on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    static func parse(tokens: [String]) throws -> Countable {
        if tokens.first == String(JsonElement.startOfArray), tokens.last == String(JsonElement.endOfArray) {
            return try parse(array: tokens)
        } else if tokens.first == String(JsonElement.startOfObject), tokens.last == String(JsonElement.endOfObject) {
            return try parse(object: tokens)
        } else {
            throw TypeError.unsupportedType
        }
    }
    
    private static func parse(array: [String]) throws -> JsonArray {
        let arrayTokens = refine(tokens: array)
        let data: [JsonType] = try makeData(arrayTokens: arrayTokens)
        
        return try JsonArray(array: data)
    }
    
    private static func parse(object: [String]) throws -> JsonObject {
        let objectTokens = refine(tokens: object)
        let data = try makeData(objectTokens: objectTokens)
        
        return try JsonObject(object: data)
    }
    
    private static func refine(tokens: [String]) -> [[String]] {
        var tokens = tokens
        tokens.removeFirst()
        tokens.removeLast()
        
        var refineResult: [[String]] = []
        var incompleteTypeTokens: [String] = []
        
        for token in tokens {
            incompleteTypeTokens.append(token)
            
            if isTypeComplete(incompleteTypeTokens) {
                refineResult.append(incompleteTypeTokens)
                incompleteTypeTokens.removeAll()
            }
            
            if incompleteTypeTokens.first == String(JsonElement.whitespace) || incompleteTypeTokens.first == String(JsonElement.comma) {
                incompleteTypeTokens.removeAll()
            }
        }
        
        return refineResult
    }
    
    private static func isTypeComplete(_ incompleteTypeTokens: [String]) -> Bool {
        let pairResult = JsonElement.pair(value: incompleteTypeTokens.first?.first)
        
        if pairResult != incompleteTypeTokens.last?.last, pairResult != nil {
            return false
        }
        
        if incompleteTypeTokens.first == String(JsonElement.whitespace) || incompleteTypeTokens.first == String(JsonElement.comma) {
            return false
        }
        
        return true
    }
    
    private static func makeData(arrayTokens: [[String]]) throws -> [JsonType] {
        var data: [JsonType] = []
        
        for tokens in arrayTokens {
            data.append(try convert(tokens: tokens))
        }
        
        return data
    }
    
    private static func makeData(objectTokens: [[String]]) throws -> [String : JsonType] {
        var data: [String : JsonType] = [:]
        var key = ""
        
        for tokens in objectTokens {
            if key.isEmpty {
                key = tokens.joined()
                
                continue
            }
            
            if tokens.joined() != String(JsonElement.colon) {
                data[key] = try convert(tokens: tokens)
                key.removeAll()
            }
        }
        
        return data
    }
    
    private static func convert(tokens: [String]) throws -> JsonType {
        let token = tokens.joined()
        
        if let result = Int(token) {
            return result
        }
        
        if token == JsonElement.true || token == JsonElement.false {
            return token == JsonElement.true ? true : false
        }
        
        if token.first == JsonElement.doubleQuotion, token.last == JsonElement.doubleQuotion {
            return token
        }
        
        if token.first == JsonElement.startOfObject, token.last == JsonElement.endOfObject {
            return try parse(object: tokens)
        }
        
        if token.first == JsonElement.startOfArray, token.last == JsonElement.endOfArray {
            return try parse(array: tokens)
        }
        
        throw ParseError.invalidValue
    }
}
