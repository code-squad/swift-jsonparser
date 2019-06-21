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
        
        var unfinishedTokens: [String] = []
        var data: [JsonType] = []
        
        for token in tokens {
            unfinishedTokens.append(token)
            
            if isTokenFinish(unfinishedTokens) {
                data.append(try convert(tokens: unfinishedTokens))
                unfinishedTokens.removeAll()
            }
            
            if unfinishedTokens.first == String(JsonElement.whitespace) || unfinishedTokens.first == String(JsonElement.comma) {
                unfinishedTokens.removeAll()
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
    
    private static func isTokenFinish(_ unfinishedTokens: [String]) -> Bool {
        let pairResult = JsonElement.pair(value: unfinishedTokens.first?.first)
        
        if pairResult != unfinishedTokens.last?.last, pairResult != nil {
            return false
        }
        
        if unfinishedTokens.first == String(JsonElement.whitespace) || unfinishedTokens.first == String(JsonElement.comma) {
            return false
        }
        
        return true
    }
    
    private static func separateObject(tokens: [String]) -> [[String]] {
        var objectTokens: [[String]] = []
        var unfinishedTokens: [String] = []
        
        for token in tokens {
            if token == String(JsonElement.comma) {
                objectTokens.append(unfinishedTokens)
                unfinishedTokens.removeAll()
                
                continue
            }
            
            unfinishedTokens.append(token)
        }
        
        objectTokens.append(unfinishedTokens)
        
        return objectTokens
    }
    
    private static func refine(object: [String]) throws -> [String] {
        var unfinishedTokens: [String] = []
        var result: [String] = []
        
        for token in object {
            unfinishedTokens.append(token)
            
            if isTokenFinish(unfinishedTokens) {
                result.append(unfinishedTokens.joined())
                unfinishedTokens.removeAll()
            }
            
            if unfinishedTokens.first == String(JsonElement.whitespace) {
                unfinishedTokens.removeAll()
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
