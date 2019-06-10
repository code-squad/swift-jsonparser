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
        case parseJSONValueFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidToken(let token):
                return "유효하지 않은 토큰 \(token) 입니다."
            case .parseJSONValueFailed:
                return "JSONValue 파싱에 실패하였습니다"
            }
        }
    }
    
    private var isTokenAvailable: Bool {
        return position < tokens.count
    }
    private let tokens: [Token]
    private var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    private mutating func getNextToken() -> Token? {
        guard isTokenAvailable else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
    
    private mutating func getString() -> String {
        var value = ""
        
        while let token = getNextToken(), token != .doubleQuotation {
            guard case let .string(stringValue) = token else {
                return value
            }
            value = value + stringValue
        }
        return value
    }
    
    private mutating func getJSONArray() throws -> [JSONValue]? {
        var jsonArray = [JSONValue]()
        
        while let token = getNextToken(), token != .closeSquareBracket {
            if let value = try getValue() {
                jsonArray.append(value)
            }
        }
        
        return jsonArray
    }
    
    private mutating func getValue() throws -> JSONValue? {
        
        if let token = getNextToken() {
            switch token {
            case .openSquareBracket:
                return try getJSONArray()
            case .doubleQuotation:
                return getString()
            case .number(let number):
                return number
            case .bool(let bool):
                return bool
            case .comma:
                return nil
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        return nil
    }
    
    mutating func parse() throws -> JSONValue {
        if let jsonValue = try getValue() {
            return jsonValue
        }
        throw Parser.Error.parseJSONValueFailed
    }
}
