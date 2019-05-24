//
//  JSONValueFactory.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONValueFactory {
    static let trueString = "true"
    static let falseString = "false"
    
    static func make(token: String) throws -> JSONValue {
        let firstCharacter = token[token.startIndex]
        if JSONSymbols.doubleQuotation.equals(firstCharacter) {
            return String(token)
        }
        if token == trueString || token == falseString {
            guard let convertedValue = Bool(token) else {
                throw JSONError.impossibleToCreateJSONValue
            }
            return convertedValue
        }
        guard let numberValue = Int(token) else {
            throw JSONError.impossibleToCreateJSONValue
        }
        return numberValue
    }
    
}
