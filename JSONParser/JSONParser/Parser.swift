//
//  Parser.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    private var converter: JSONConvertible
    private var position = 0
    
    init(converter: JSONConvertible) {
        self.converter = converter
    }
    
    mutating func nextToken() -> String? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
    
    mutating func parse(tokens: [String]) -> JSONContainerType? {
        while let token = nextToken() {
            switch token {
            case JSONKeyword.leftSquareBracket:
                let array = parseArray(tokens: tokens)
                return array
            case JSONKeyword.leftCurlyBracket:
                let object = parseObject(tokens: tokens)
                return object
            default:
                return nil
            }
        }
        return nil
    }
    
    mutating private func parseArray(tokens: [String]) -> JSONContainerType {
        var arrayData: [JSONValueType] = []
        
        while let token = nextToken() {
            guard token != JSONKeyword.rightSquareBracket else {
                return arrayData
            }
            
            switch token {
            case JSONKeyword.leftCurlyBracket:
                let objectData = parseObject(tokens: tokens)
                arrayData.append(objectData)
            default:
                guard let value = makeJSONType(by: token) else {
                    continue
                }
                arrayData.append(value)
            }
        }
        return arrayData
    }
    
    mutating private func parseObject(tokens: [String]) -> JSONContainerType {
        var objectData: [String: JSONValueType] = [:]
        
        while let token = nextToken() {
            
            guard token != JSONKeyword.rightCurlyBracket else {
                return objectData
            }
            
            guard token == JSONKeyword.colon else {
                continue
            }
            
            let previousPosition = position - 2
            let nextPosition = position
            let key = tokens[previousPosition]
            let rawValue = tokens[nextPosition]
            
            guard let value = makeJSONType(by: rawValue) else {
                continue
            }
        
            objectData[key] = value
        }
        return objectData
    }
    
    private func makeJSONType(by token: String) -> JSONValueType? {
        guard let value = converter.convertSingleValue(token: token) else {
            return nil
        }
        return value
    }
}
