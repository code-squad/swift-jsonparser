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
        var numberOfComma = 0
        
        while let token = getNextToken() {
            switch token {
            case .doubleQuotation:
                let stringValue = getString()
                jsonArray.append(stringValue)
            case .number(let number):
                jsonArray.append(number)
            case .bool(let bool):
                jsonArray.append(bool)
            case .comma:
                guard numberOfComma == jsonArray.count - 1 && position != tokens.endIndex else {
                    throw Parser.Error.invalidToken(token)
                }
                numberOfComma = numberOfComma + 1
            case .closeSquareBracket:
                return jsonArray
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        throw Parser.Error.parseJSONArrayFailed
    }
    
    private mutating func getContainerValue() throws -> JSONContainerValue? {
        
        if let token = getNextToken() {
            switch token {
            case .openSquareBracket:
                return try getJSONArray()
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        throw Parser.Error.notExistToken
    }
    
    mutating func parse() throws -> JSONContainerValue {
        if let jsonValue = try getContainerValue() {
            return jsonValue
        }
        throw Parser.Error.parseJSONValueFailed
    }
}
