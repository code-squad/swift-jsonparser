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
        guard let tokenSymbol = JSONSymbols(rawValue: token) else {
            throw ParserError.invalidSymbolToParse
        }
        switch tokenSymbol {
        case .openBrace:
            return try parseObject()
        case .openBracket:
            return try parseArray()
        default:
            throw ParserError.invalidFirstSymbolOfJSONData
        }
    }
    
    private mutating func parseObject() throws -> JSONValue {
        var object = JSONObject()
        var token = try tokenReader.next()
        while JSONSymbols.closedBrace.notEquals(token) {
            if JSONSymbols.comma.equals(token) {
                token = try tokenReader.next()
            }
            if isString(token) {
                let key = token
                token = try tokenReader.next()
                let value = try parseValue(token)
                object.add(key: key, value: value)
            }
            token = try tokenReader.next()
        }
        return object
    }
    
    private func isString(_ token: String) -> Bool {
        let firstCharacter = token[token.startIndex]
        return JSONSymbols.doubleQuotation.equals(firstCharacter)
    }
    
    private mutating func parseArray() throws -> JSONValue {
        var jsonArray = JSONArray()
        var token = try tokenReader.next()
        while JSONSymbols.closedBracket.notEquals(token) {
            if JSONSymbols.comma.equals(token) {
                token = try tokenReader.next()
            }
            let parsedValue = try parseValue(token)
            jsonArray.append(parsedValue)
            token = try tokenReader.next()
        }
        return jsonArray 
    }
    
    private mutating func parseValue(_ token: String) throws -> JSONValue {
        guard let tokenSymbol = JSONSymbols(rawValue: token) else {
            return try JSONValueFactory.make(token: token)
        }
        switch tokenSymbol {
        case .openBrace:
            return try parseObject()
        case .openBracket:
            return try parseArray()
        case .colon:
            return try parseValue(try tokenReader.next())
        default:
            throw ParserError.impossibleToParse 
        }
    }
    
}
