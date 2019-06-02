//
//  TokenConverter.swift
//  JSONParser
//
//  Created by 이동영 on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TokenConverter: Converter {
    typealias Before = Token
    typealias After = JsonValue
    
    func convert(before: Token) -> JsonValue? {
        var jsonValue: JsonValue?
        
        switch before {
        case .Number(let number):
            jsonValue = Int(number)
        case .Bool(let bool):
            jsonValue = Bool(bool)
        case .String(let string):
            jsonValue = String(string)
        case .List(let tokens):
            var parser = JsonParser.init(tokens: tokens)
            jsonValue = parser.parse()
        case .Object(let tokens):
            var parser = JsonParser.init(tokens: tokens)
            jsonValue = parser.parse()
        default:
            jsonValue = nil
        }
        return jsonValue
    }
    
}
