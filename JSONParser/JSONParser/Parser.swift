//
//  Parser.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    private var tokenReader: TokenReader
    
    init(tokens: [String]) {
        self.tokenReader = TokenReader(tokens: tokens)
    }
    
    mutating func parse() throws -> JSONValue {
        let token = try tokenReader.next()
        switch token {
        case JSONSymbols.openBrace.inString:
            return try parseObject()
        case JSONSymbols.openBracket.inString:
            return try parseArray()
        default:
            throw ParserError.invalidFirstSymbolOfJSONData
        }
    }
    
    private mutating func parseObject() throws -> JSONValue {
        var jsonObject = Dictionary<String, JSONValue>()
        var token = try tokenReader.next()
        while JSONSymbols.closedBrace.inString != token {
            if JSONSymbols.comma.inString == token {
                token = try tokenReader.next()
            }
            if isString(token) {
                let key = token
                token = try tokenReader.next()
                let value = try parseValue(token)
                jsonObject[key] = value
            }
            token = try tokenReader.next()
        }
        return jsonObject
    }
    
    private func isString(_ token: String) -> Bool {
        let firstCharacter = token[token.startIndex]
        return JSONSymbols.doubleQuotation == firstCharacter
    }
    
    private mutating func parseArray() throws -> JSONValue {
        var jsonArray = Array<JSONValue>()
        var token = try tokenReader.next()
        while JSONSymbols.closedBracket.inString != token {
            if JSONSymbols.comma.inString == token {
                token = try tokenReader.next()
            }
            let parsedValue = try parseValue(token)
            jsonArray.append(parsedValue)
            token = try tokenReader.next()
        }
        return jsonArray
    }
    
    private mutating func parseValue(_ token: String) throws -> JSONValue {
        switch token {
        case JSONSymbols.openBrace.inString:
            return try parseObject()
        case JSONSymbols.openBracket.inString:
            return try parseArray()
        case JSONSymbols.colon.inString:
            return try parseValue(try tokenReader.next())
        default:
            return try JSONValueFactory.make(token: token)
        }
    }
    
}
