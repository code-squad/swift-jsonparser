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
    
    func parse(tokens: [String]) -> JSONContainerType? {
        guard let firstToken = tokens.first else {
            return nil
        }
        
        if firstToken == JSONKeyword.leftSquareBracket {
            let array = parseArray(tokens: tokens)
            return array
        } else if firstToken == JSONKeyword.leftCurlyBracket {
            let object = parseObject(tokens: tokens)
            return object
        }
        
        return nil
    }
    
    private func parseArray(tokens: [String]) -> JSONContainerType {
        var arrayDatas: [JSONValueType] = []
        let objectTokens = makeObject(tokens: tokens)
        for objectToken in objectTokens {
            if objectToken.count > 1 {
                if let object = converter.convertMultipleValue(tokens: objectToken) {
                    arrayDatas.append(object)
                }
            } else {
                if let object = converter.convertSingleValue(token: objectToken.joined()){
                    arrayDatas.append(object)
                }
            }
        }
        return arrayDatas
        
    }
    
    private func parseObject(tokens: [String]) -> JSONContainerType {
        var object: [String: JSONValueType] = [:]
        
        for (index, token) in tokens.enumerated() {
            if token == JSONKeyword.colon {
                let key = tokens[index - 1]
                let rawValue = tokens[index + 1]
                guard let value = makeJSONType(by: rawValue) else {
                    continue
                }
                object[key] = value
            }
        }
        return object
    }
    
    private func makeJSONType(by token: String) -> JSONValueType? {
        guard let value = converter.convertSingleValue(token: token) else {
            return nil
        }
        return value
    }
    
    private func makeObject(tokens: [String]) -> [[String]] {
       
        let curlyBrackets = [JSONKeyword.leftCurlyBracket, JSONKeyword.rightCurlyBracket]
        var isInObject = false
        var object: [[String]] = []
        var objectTokens: [String] = []
    
        for token in tokens {
            
            if curlyBrackets.contains(token) {
                isInObject.toggle()
            }
            
            if isInObject {
                objectTokens.append(token)
                continue
            }
            
            guard objectTokens.count > 0 else {
                object.append([token])
                continue
            }
            
            object.append(objectTokens)
            objectTokens.removeAll()
        }
        
        return object
    }
}
