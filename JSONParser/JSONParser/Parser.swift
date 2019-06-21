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
        var tokens = array
        tokens.removeFirst()
        tokens.removeLast()
        
        var incompleteTypeTokens: [String] = []
        var data: [JsonType] = []
        
        for token in tokens {
            incompleteTypeTokens.append(token)
            
            if isTypeComplete(incompleteTypeTokens) {
                data.append(try convert(tokens: incompleteTypeTokens))
                incompleteTypeTokens.removeAll()
            }
            
            if incompleteTypeTokens.first == String(JsonElement.whitespace) || incompleteTypeTokens.first == String(JsonElement.comma) {
                incompleteTypeTokens.removeAll()
            }
        }
        
        return try JsonArray(array: data)
    }
    
    private static func parse(object: [String]) throws -> JsonObject {
        var tokens = object
        tokens.removeFirst()
        tokens.removeLast()
        
        var data: [String : JsonType] = [:]
        
        let objectTokens = separateObject(tokens: tokens)
        
        for token in objectTokens {
            let refineResult = try refine(object: token)
            
            guard let key = refineResult.first, let value = refineResult.last else {
                throw ParseError.invalidValue
            }
            
            data[key] = try convert(tokens: [value])
        }
        
        return try JsonObject(object: data)
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
    
    private static func separateObject(tokens: [String]) -> [[String]] {
        var objectTokens: [[String]] = []
        var incompleteTypeTokens: [String] = []
        
        for token in tokens {
            if token == String(JsonElement.comma) {
                objectTokens.append(incompleteTypeTokens)
                incompleteTypeTokens.removeAll()
                
                continue
            }
            
            incompleteTypeTokens.append(token)
        }
        
        objectTokens.append(incompleteTypeTokens)
        
        return objectTokens
    }
    
    private static func refine(object: [String]) throws -> [String] {
        var incompleteTypeTokens: [String] = []
        var result: [String] = []
        
        for token in object {
            incompleteTypeTokens.append(token)
            
            if isTypeComplete(incompleteTypeTokens) {
                result.append(incompleteTypeTokens.joined())
                incompleteTypeTokens.removeAll()
            }
            
            if incompleteTypeTokens.first == String(JsonElement.whitespace) {
                incompleteTypeTokens.removeAll()
            }
        }
        
        return result
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
        
        throw ParseError.invalidValue
    }
}
