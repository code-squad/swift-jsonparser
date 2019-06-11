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
