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
        if tokens.first == "[", tokens.last == "]" {
            return try parse(array: tokens)
        } else {
            throw TypeError.unsupportedType
        }
    }
    
    private static func parse(array: [String]) throws -> JsonArray {
        var tokens = array
        tokens.removeFirst()
        tokens.removeLast()
        
        var data: [JsonType] = []
        var datum: String = ""
        var isString = false
        
        for token in tokens {
            if token == "\"", isString {
                isString = false
                datum.append("\"")
                data.append(try convert(token: datum))
                datum.removeAll()
                continue
            }
            
            if token == "\"", !isString {
                isString = true
                datum.append("\"")
                continue
            }
            
            if isString {
                datum = datum + token
                continue
            }
            
            if !(token == "," || token == " ") {
                data.append(try convert(token: token))
            }
        }
        
        return JsonArray(array: data)
    }
    
    private static func convert(token: String) throws -> JsonType {
        if let result = Int(token) {
            return result
        }
        
        if token == "true" {
            return true
        }
        
        if token == "false" {
            return false
        }
        
        if token.first == "\"", token.last == "\"" {
            return token
        }
        
        throw ParseError.invalidValue
    }
}
