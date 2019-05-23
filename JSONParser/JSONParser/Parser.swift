//
//  Parser.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    private var validator: Validatable
    
    init(validator: Validatable) {
        self.validator = validator
    }
    
    func parse(tokens: [String]) -> [JSONValueType] {
        var values: [JSONValueType] = []
        
        for token in tokens {
            if validator.hasQuotation(in: token) {
                let stringToken = removeQuotation(in: token)
                values.append(stringToken)
            }
            
            if validator.isBool(of: token) {
                let boolToken = matchBool(in: token)
                values.append(boolToken)
            }
            
            if validator.isNumber(of: token) {
                let numberToken = toNumber(in: token)
                values.append(numberToken)
            }
        }
        return values
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
