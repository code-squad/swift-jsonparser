//
//  Parser.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    enum Error: Swift.Error {
        case invalidToken(Token)
        case notExistToken
        case parseJSONValueFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidToken(let token):
                return "유효하지 않은 토큰 \(token) 입니다."
            case .notExistToken:
                return "토큰이 존재하지 않습니다."
            case .parseJSONValueFailed:
                return "JSONValue 파싱에 실패하였습니다."
            }
        }
    }
    
    private var tokenReader: Reader<Token>
    
    init(tokenReader: Reader<Token>) {
        self.tokenReader = tokenReader
    }
    
    mutating func parseJSONValue() throws -> JSONValue {
        
        if let token = tokenReader.peek() {
            switch token {
            case .openSquareBracket:
                return try parseJSONArray()
            case .openCurlyBracket:
                return try parseJSONObject()
            case .string(let string):
                return string
            case .number(let number):
                return number
            case .bool(let bool):
                return bool
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        throw Parser.Error.parseJSONValueFailed
    }
    
    private mutating func parseJSONArray() throws -> [JSONValue] {
        var jsonArray = [JSONValue]()
        
        tokenReader.advance()
        while let token = tokenReader.peek(), token != .closeSquareBracket {
            skipCommaToken()
            let jsonValue = try parseJSONValue()
            jsonArray.append(jsonValue)
            tokenReader.advance()
        }
        return jsonArray
    }
    
    private mutating func parseJSONObject() throws -> [String: JSONValue] {
        var jsonObject = [String: JSONValue]()
        
        tokenReader.advance()
        while let token = tokenReader.peek(), token != .closeCurlyBracket {
            skipCommaToken()
            let (key, value) = try parseKeyValue()
            jsonObject.updateValue(value, forKey: key)
            tokenReader.advance()
        }
        return jsonObject
    }
    
    private mutating func parseKeyValue() throws -> (String, JSONValue) {
        guard case let .string(key)? = tokenReader.peek() else {
            throw Parser.Error.parseJSONValueFailed
        }
        tokenReader.advance()
        guard tokenReader.peek() == .colon else {
            throw Parser.Error.parseJSONValueFailed
        }
        tokenReader.advance()
        let value = try parseJSONValue()
        return (key, value)
    }
    
    private mutating func skipCommaToken() {
        if let token = tokenReader.peek(), token == .comma {
            tokenReader.advance()
        }
    }
}
