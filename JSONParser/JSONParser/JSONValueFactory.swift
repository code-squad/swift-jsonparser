//
//  JSONValueFactory.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONValueFactory {
    static func make(token: String) throws -> JSONValue {
        let firstCharacter = token[token.startIndex]
        if JSONSymbols.doubleQuotation == firstCharacter {
            return token
        }
        if token == JSONSymbols.trueString || token == JSONSymbols.falseString {
            return try make(boolean: token)
        }
        guard let numberValue = Int(token) else {
            throw JSONValueFactoryError.impossibleToconvertIntoNumber
        }
        return numberValue
    }
    
    private static func make(boolean: String) throws -> Bool{
        switch boolean {
        case JSONSymbols.trueString:
            return true
        case JSONSymbols.falseString:
            return false
        default:
            throw JSONValueFactoryError.impossibleToConvertIntoBool
        }
    }
}
