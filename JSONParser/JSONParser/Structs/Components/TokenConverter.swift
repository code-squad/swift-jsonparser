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
        case .number(let number):
            jsonValue = Int(number)
        case .bool(let bool):
            jsonValue = Bool(bool)
        case .string(let string):
            jsonValue = String(string)
        default:
            jsonValue = nil
        }
        return jsonValue
    }
    
}
