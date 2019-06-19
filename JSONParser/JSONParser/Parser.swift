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
        case parseJSONArrayFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidToken(let token):
                return "유효하지 않은 토큰 \(token) 입니다."
            case .notExistToken:
                return "토큰이 존재하지 않습니다."
            case .parseJSONValueFailed:
                return "JSONValue 파싱에 실패하였습니다."
            case .parseJSONArrayFailed:
                return "JSONArray 파싱에 실패하였습니다."
            }
        }
    }
    
    private var tokenReader: TokenReader
    
    init(tokenReader: TokenReader) {
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
            case .true:
                return true
            case .false:
                return false
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
            if token == .comma {
                tokenReader.advance()
                continue
            }
            let jsonValue = try parseJSONValue()
            jsonArray.append(jsonValue)
            tokenReader.advance()
        }
        return jsonArray
    }
    
    private mutating func parseJSONObject() throws -> [String: JSONValue] {
        var jsonObject = [String: JSONValue]()
        var key = ""
        
        tokenReader.advance()
        while let token = tokenReader.peek(), token != .closeCurlyBracket {
            
            if token == .comma || token == .colon {
                tokenReader.advance()
                continue
            }
            
            let value = try parseJSONValue()
            
            if let string = value.string {
                key = string
            } else {
                jsonObject.updateValue(value, forKey: key)
                key = ""
            }
            tokenReader.advance()
        }
        return jsonObject
    }
}
