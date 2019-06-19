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
    
    private mutating func getNextToken() -> Token? {
        guard isTokenAvailable else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
    
    private mutating func getValue() throws -> JSONValue {
        
        if let token = getNextToken() {
            switch token {
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
    
    private mutating func parseJSONObject() throws -> [String: JSONValue] {
        var jsonObject = [String: JSONValue]()
        var k: String?
        var v: JSONValue?
        
        while let token = getNextToken() {
            switch token {
            case .openCurlyBracket, .comma:
                let value = try getValue()
                k = "\(value)"
            case .colon:
                let value = try getValue()
                v = value
                if let key = k,
                    let value = v {
                    jsonObject.updateValue(value, forKey: key)
                    k = nil
                    v = []
                }
            case .closeCurlyBracket:
                return jsonObject
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        throw Parser.Error.parseJSONValueFailed
    }
    
    mutating func parse() throws -> JSONValue {
        if let token = currentToken {
            switch token {
            case .openSquareBracket:
                return try parseJSONArray()
            case .openCurlyBracket:
                return try parseJSONObject()
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        throw Parser.Error.notExistToken
    }
}
