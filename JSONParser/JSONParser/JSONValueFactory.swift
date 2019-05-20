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
        guard let firstCharacter = token.first else { throw JSONError.impossibleToCreateJSONValue }
        
        if String(firstCharacter) == JSONSymbols.doubleQuotation {
            return String(token)
        }
        if token == trueString {
            return true
        }
        if token == falseString {
            return false
        }
        
        guard let numberValue = Int(token) else {
            throw JSONError.impossibleToCreateJSONValue
        }
        return numberValue
    }
    
}
