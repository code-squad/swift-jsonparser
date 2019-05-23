//
//  Validator.swift
//  JSONParser
//
//  Created by CHOMINJI on 14/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Validator: Validatable {
    
    func hasQuotation(in token: String) -> Bool {
        guard token.first == "\"" && token.last == "\"" else {
            return false
        }
        return true
    }
    
    func isBool(of token: String) -> Bool {
        guard JSONKeyword.bools.contains(token) else {
            return false
        }
        return true
    }
    
    func isNumber(of token: String) -> Bool {
        let tokenCharacters = CharacterSet(charactersIn: token)
        let differenceCharacters = tokenCharacters.subtracting(CharacterSet.decimalDigits)
        return differenceCharacters.isEmpty
    }
}

protocol Validatable {
    func hasQuotation(in token: String) -> Bool
    func isBool(of token: String) -> Bool
    func isNumber(of token: String) -> Bool
}
