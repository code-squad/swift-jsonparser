//
//  JSONParser.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private var reader: TokenReader
    
    init(tokens: [String]) {
        self.reader = TokenReader(tokens: tokens)
    }
    
    mutating func parse() throws -> JSONDataType {
        let tokens = try reader.getNextToken()
        switch tokens {
        case "[" :
            return try parseArray()
        case "{" :
            return  try parseObject()
        default :
            throw JSONError.TokensError
        }
    }
    
    private mutating func parseArray() throws -> JSONDataType {
        var token = try reader.getNextToken()
        var result = [JSONDataType]()
        while String(Token.endArray) != token {
            if token == String(Token.valueSeparator){
                token = try reader.getNextToken()
            }
            let value = try self.parseMultiValue(token)
            result.append(value)
            token = try reader.getNextToken()
        }
        return result
    }
    
    
    private func parseString(data: String) -> String? {
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
        var token = try reader.getNextToken()
        while String(Token.endObject) != token {
            if String(Token.valueSeparator) == token {
                token = try reader.getNextToken()
            }
            if isString(token: token) {
                let key = token
                token = try reader.getNextToken()
                let value = try parseSingleValue(data: token)
                objectData[key] = value
            }
            token = try reader.getNextToken()
        }
        return objectData
    }
    
    private func isString(token: String) -> Bool {
        let firstCharacter = token.first
        return Token.quatationMark == firstCharacter
    }
    
    private mutating func scanToken(token: String?) throws -> (String,JSONDataType){
        guard let key = token else { throw JSONError.TokensError }
        let token = try reader.getNextToken()
        let value = try parseSingleValue(data: token)
        return (key,value)
    }
    
    private mutating func parseSingleValue(data: String) throws -> JSONDataType {
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
            return try parseMultiValue(try reader.getNextToken())
        default:
            return try parseSingleValue(data: token)
        }
    }
}

