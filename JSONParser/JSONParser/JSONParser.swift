//
//  JSONParser.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private var readTokens: TokenReader
    
    init(tokens: [String]) {
        self.readTokens = TokenReader(tokens: tokens)
    }
    
    mutating func parse() throws -> JSONDataType {
        let tokens = try readTokens.getNextToken()
        switch tokens {
        case "[" :
           return try parseArray()
        case "{" :
           return  try parseObject()
        default :
            throw JSONError.TokensError
        }
    }
    
    
    mutating func parseArray() throws -> JSONDataType {
        var token = try readTokens.getNextToken()
        var result = [JSONDataType]()
        while String(Token.endArray) != token {
            if token == String(Token.valueSeparator){
                token = try readTokens.getNextToken()
            }
            
            let value = try parseSingleValue(data: token)
            result.append(value)
            token = try readTokens.getNextToken()
        }
        return result
    }
    
    
    private  func parseString(data: String) -> String? {
        guard data.first == "\"" && data.last == "\"" else {
            return nil
        }
        var data = data
        data.removeFirst()
        data.removeLast()
        return data
    }
    
    private func parseNumber(data: String) -> Number? {
        return Number(data)
    }
    
    private func parseBool(data: String) -> Bool? {
        return Bool(data)
    }
    
    private mutating func parseObject() throws -> JSONDataType {
        var objectData = Dictionary<String, JSONDataType>()
        var token = try readTokens.getNextToken()
        while String(Token.endObject) != token {
            if String(Token.valueSeparator) == token {
                token = try readTokens.getNextToken()
            }
            if isString(token: token) {
                let key = token
                token = try readTokens.getNextToken()
                let value = try parseSingleValue(data: token)
                objectData[key] = value
            }
            token = try readTokens.getNextToken()
        }
        return objectData
    }
    
    private mutating func isString(token: String) -> Bool {
        let firstCharacter = token.first
        return Token.quatationMark == firstCharacter
    }
    
    mutating func scanToken(token: String?) throws -> (String,JSONDataType){
        guard let key = token else { throw JSONError.TokensError }
        let token = try readTokens.getNextToken()
        let value = try parseSingleValue(data: token)
        return (key,value)
    }
    
    
    func parseSingleValue(data: String) throws -> JSONDataType {
        if let string = parseString(data: data) {
            return string
        } else if let number = parseNumber(data: data) {
            return number
        } else if let bool = parseBool(data: data) {
            return bool
        }
        
        throw JSONError.wrongValue
    }
    
    private mutating func parseMultiValue(_ token: String) throws -> JSONDataType {
        switch token {
        case String(Token.beginObject):
            return try parseObject()
        case String(Token.beginArray):
            return try parseArray()
        case String(Token.nameSeparator):
            return try parseMultiValue(try readTokens.getNextToken())
        default:
            return try parseSingleValue(data: token)
        }
    }
}
