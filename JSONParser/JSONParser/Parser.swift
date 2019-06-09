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
        
        var localizedDescription: String {
            switch self {
            case .invalidToken(let token):
                return "유효하지 않은 토큰 \(token) 입니다."
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
    
    private mutating func getValue() throws -> JSONValue? {
        
        if let token = getNextToken() {
            switch token {
            case .doubleQuotation:
                return getString()
            case .number(let number):
                return number
            case .bool(let bool):
                return bool
            case .closeSquareBracket:
                return nil
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        return nil
    }
    
    mutating func parse() throws -> [JSONValue] {
        var jsonArray = [JSONValue]()
        
        if let token = getNextToken(),
            let value = try getValue(), token == .openSquareBracket {
            jsonArray.append(value)
        }
        
        while let token = getNextToken(),
            let value = try getValue(), token == .comma, token != .closeSquareBracket {
                jsonArray.append(value)
        }
        
        return jsonArray
    }
}
