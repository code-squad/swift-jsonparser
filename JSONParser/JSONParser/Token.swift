//
//  Token.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

enum Token: Equatable {
    case openSquareBracket
    case closeSquareBracket
    case doubleQuotation
    case comma
    case bool(Bool)
    case string(String)
    case number(Int)
    
    var description: String {
        switch self {
        case .openSquareBracket:
            return "["
        case .closeSquareBracket:
            return "]"
        case .doubleQuotation:
            return "\""
        case .comma:
            return ","
        case .bool(let bool):
            return String(bool)
        case .string(let string):
            return string
        case .number(let number):
            return String(number)
        }
    }
    
    static func ==(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.openSquareBracket, .openSquareBracket),
             (.closeSquareBracket, .closeSquareBracket),
             (.doubleQuotation, .doubleQuotation),
             (.comma, .comma):
            return true
        case (.bool(let lb), .bool(let rb)):
            return lb == rb
        case (.string(let ls), .string(let rs)):
            return ls == rs
        case (.number(let ln), .number(let rn)):
            return ln == rn
        default:
            return false
        }
    }
}
