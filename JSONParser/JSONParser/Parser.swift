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
        
        var unfinishedTokens: [String] = []
        var data: [JsonType] = []
        
        for token in tokens {
            unfinishedTokens.append(token)
            
            if isTokenFinish(unfinishedTokens) {
                data.append(try convert(tokens: unfinishedTokens))
                unfinishedTokens.removeAll()
            }
            
            if unfinishedTokens.first == " " || unfinishedTokens.first == "," {
                unfinishedTokens.removeAll()
            }
        }
        
        return try JsonArray(array: data)
    }
    
    private static func isTokenFinish(_ unfinishedTokens: [String]) -> Bool {
        let pairResult = JsonElement.pair(value: unfinishedTokens.first?.first)
        
        if pairResult != unfinishedTokens.last?.last {
            if pairResult != nil {
                return false
            }
        }
        
        if unfinishedTokens.first == " " || unfinishedTokens.first == "," {
            return false
        }
        
        return true
    }
    
    private static func parse(object: [String]) throws -> JsonObject {
        var tokens = object
        tokens.removeFirst()
        tokens.removeLast()
        
        var unfinishedToken = ""
        var data: [String : JsonType] = [:]
        
        return try JsonObject(object: data)
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
