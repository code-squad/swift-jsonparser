//
//  Parser.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class Parser {
    private var converter: JSONConvertible = Converter()
    private var scanner: TokenScanner
    private var tokens: [String]
    
    init(tokens: [String]) {
        self.tokens = tokens
        self.scanner = TokenScanner(tokens: tokens)
    }
    
    let parseTable = [JSONKeyword.leftSquareBracket: parseArray,
                      JSONKeyword.leftCurlyBracket: parseObject]
    
    func parse() -> JSONContainerType? {
        while let token = scanner.nextToken(),
            let parseMethod = parseTable[token] {
                return parseMethod(self)()
        }
        return nil
    }
    
    private func parseArray() -> JSONContainerType {
        var arrayData: [JSONValueType] = []
        
        while let token = scanner.nextToken() {
            guard token != JSONKeyword.rightSquareBracket else {
                return arrayData
            }
            if let parseMethod = parseTable[token] {
                arrayData.append(parseMethod(self)())
            } else {
                guard let value = makeJSONType(by: token) else {
                    continue
                }
                arrayData.append(value)
            }
        }
        return arrayData
    }
    
    private func parseObject() -> JSONContainerType {
        var objectData: [String: JSONValueType] = [:]
        
        while let token = scanner.nextToken() {
            guard token != JSONKeyword.rightCurlyBracket else {
                return objectData
            }
            guard token == JSONKeyword.colon else {
                continue
            }
            guard let key = scanner.peekPreviousToken,
                let rawValue = scanner.peekNextToken else {
                continue
            }
            guard let value = makeJSONType(by: rawValue) else {
                continue
            }
            objectData[key] = value
        }
        return objectData
    }
    
    private func makeJSONType(by token: String) -> JSONValueType? {
        guard let value = converter.convert(token: token) else {
            return nil
        }
        return value
    }
}

struct TokenScanner {
    private var tokens: [String]
    private var position = 0
    
    init(tokens: [String]) {
        self.tokens = tokens
    }
    
    var peekPreviousToken: String? {
        guard position > 2 else {
            return nil
        }
        let previousPosition = position - 2
        let key = tokens[previousPosition]
        return key
    }
    
    var peekNextToken: String? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        return token
    }
    
    mutating func nextToken() -> String? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
}
