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
        if JSONSymbols.doubleQuotation == firstCharacter {
            return token
        }
        if token == trueString || token == falseString {
            return try make(boolean: token)
        }
        guard let numberValue = Int(token) else {
            throw JSONValueFactoryError.impossibleToconvertIntoNumber
        }
        return numberValue
    }
    
    private static func make(boolean: String) throws -> Bool{
        switch boolean {
        case trueString:
            return true
        case falseString:
            return false
        default:
            throw JSONValueFactoryError.impossibleToConvertIntoBool
        }
    }
}
