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
    
     func parseArray(tokens: [String]) -> [JSONDataType]? {
        var result = [JSONDataType]()
        guard tokens.first == "[" else { return nil }
        var reader = TokenReader(tokens: tokens)
        
        while let token = reader.getNextToken() {
            if let value = parseValue(data: token) {
                result.append(value)
            }
        }
        return result
    }
    
     func parseValue(data: String) -> JSONDataType? {
        if let string = parseString(data: data) {
            return string
        } else if let number = parseNumber(data: data) {
            return number
        } else if let bool = parseBool(data: data) {
            return bool
        }
        return nil
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
    
    private mutating func parseObject(data: String) throws -> [String: JSONDataType]? {
        var objectData = Dictionary<String, JSONDataType>()
        var token = readTokens.getNextToken()
        
        while String(Token.endObject) != token {
            if String(Token.valueSeparator) == token {
                token = readTokens.getNextToken()
            }
            if isString(token: data) {
                let (key,value) = try scanToken(token: data)
                objectData[key] = value
            }
            token = readTokens.getNextToken()
        }
        return objectData
    }
    
    private mutating func isString(token: String)-> Bool {
        let firstCharacter = token[token.startIndex]
        return Token.quatationMark == firstCharacter
    }
    
    mutating func scanToken(token: String?) throws -> (String,JSONDataType){
        guard let key = token else { throw JSONError.TokensError }
        guard let token = readTokens.getNextToken() else {
            throw JSONError.TokensError
        }
        guard let value = parseValue(data: token) else {
            throw JSONError.TokensError
        }
        return (key,value)
    }
}
