//
//  Token.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Token: Equatable {
    case number(Int)
    case bool(Bool)
    case value(String)
    case string(String)
    
    case ws
    case comma
    case colon
    case doubleQuotation
    
    case leftBrace
    case rightBrace
    
    case leftBraket
    case rightBraket
    
    func getValue() -> String {
        switch self {
        case .number(let value):
            return "\(value)"
        case .bool(let value):
            return "\(value)"
        case .string(let value):
            return "\(value)"
        case .ws:
            return " "
        case .colon:
            return ":"
        case .comma:
            return ","
        case .doubleQuotation:
            return "\""
        case .leftBrace:
            return "{"
        case .rightBrace:
            return "}"
        case .leftBraket:
            return "["
        case .rightBraket:
            return "]"
        case .value(let value):
            return "\(value)"
            
        }
    }
    
}
