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
    
    private var isTokenAvailable: Bool {
        return position < tokens.count
    }
    private var currentToken: Token? {
        return isTokenAvailable ? tokens[position] : nil
    }
    private let tokens: [Token]
    private var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    private mutating func advance() {
        position = position + 1
    }
    
    private mutating func getNextToken() -> Token? {
        guard isTokenAvailable else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
    
    mutating func parseJSONValue() throws -> JSONValue {
        
        if let token = currentToken {
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
        
        advance()
        while let token = currentToken, token != .closeSquareBracket {
            if token == .comma {
                advance()
                continue
            }
            let jsonValue = try parseJSONValue()
            jsonArray.append(jsonValue)
            advance()
        }
        return jsonArray
    }
    
    private mutating func parseJSONObject() throws -> [String: JSONValue] {
        var jsonObject = [String: JSONValue]()
        var key = ""
        
        advance()
        while let token = currentToken, token != .closeCurlyBracket {
            switch token {
            case .string(let string):
                key = string
            case .colon:
                advance()
                let value = try parseJSONValue()
                jsonObject.updateValue(value, forKey: key)
                key = ""
            case .comma:
                advance()
                continue
            default:
                throw Parser.Error.invalidToken(token)
            }
            advance()
        }
        return jsonObject
    }
}
