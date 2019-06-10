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
        case parseStringFailed
        case parseJSONValueFailed
        case parseJSONArrayFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidToken(let token):
                return "유효하지 않은 토큰 \(token) 입니다."
            case .notExistToken:
                return "토큰이 존재하지 않습니다."
            case .parseStringFailed:
                return "문자열 파싱에 실패하였습니다."
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
    
    private mutating func getString() throws -> String {
        
        if case let .string(stringValue)? = getNextToken(),
            let doubleQuotationToken = getNextToken(), doubleQuotationToken == .doubleQuotation {
            return stringValue
        }
        throw Parser.Error.parseStringFailed
    }
    
    private mutating func getValue() throws -> JSONValue {
        
        if let token = getNextToken() {
            switch token {
            case .doubleQuotation:
                let stringValue = try getString()
                return stringValue
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
    
    private mutating func getJSONArray() throws -> [JSONValue] {
        var jsonArray = [JSONValue]()
        
        while let token = getNextToken() {
            switch token {
            case .openSquareBracket, .comma:
                let value = try getValue()
                jsonArray.append(value)
            case .closeSquareBracket:
                return jsonArray
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        throw Parser.Error.parseJSONArrayFailed
    }
    
    mutating func parse() throws -> JSONContainerValue {
        return try getJSONArray()
    }
}
