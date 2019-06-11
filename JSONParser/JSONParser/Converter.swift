//
//  Validator.swift
//  JSONParser
//
//  Created by CHOMINJI on 14/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONConvertible {
    func convertSingleValue(token: String) -> JSONValueType?
    func convertMultipleValue(tokens: [String]) -> JSONValueType?
}

struct Converter: JSONConvertible {
    func convertSingleValue(token: String) -> JSONValueType? {
        
        if isString(of: token) {
            return removeQuotation(in: token)
        } else if isBool(of: token) {
            return matchBool(in: token)
        } else if isNumber(of: token) {
            return toNumber(in: token)
        } else {
            return nil
        }
    }
    
    func convertMultipleValue(tokens: [String]) -> JSONValueType? {
        var object: [String: JSONValueType] = [:]
        
        for (index, token) in tokens.enumerated() {
            if token == JSONKeyword.colon {
                let key = tokens[index - 1]
                let rawValue = tokens[index + 1]
                guard let value = convertSingleValue(token: rawValue) else {
                    continue
                }
                object[key] = value
            }
        }
        return object
    }
    
    private func isString(of token: String) -> Bool {
        return token.first == "\"" && token.last == "\""
    }
    
    private func isBool(of token: String) -> Bool {
        return JSONKeyword.bools.contains(token)
    }
    
    private func isNumber(of token: String) -> Bool {
        let tokenCharacters = CharacterSet(charactersIn: token)
        let differenceCharacters = tokenCharacters.subtracting(CharacterSet.decimalDigits)
        return differenceCharacters.isEmpty
    }
    
    private func removeQuotation(in token: String) -> String {
        let trimmedToken = token.dropFirst().dropLast()
        return String(trimmedToken)
    }
    
    private func matchBool(in token: String) -> Bool {
        if token == JSONKeyword.true {
            return true
        } else {
            return false
        }
    }
    
    private func toNumber(in token: String) -> Number {
        let number = Number(token) ?? -1
        return number
    }
}
