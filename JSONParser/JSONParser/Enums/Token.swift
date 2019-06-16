//
//  Token.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Token: Equatable {
    case List(Array<Token>)
    case Object(Array<Token>)
    
    case Number(Int)
    case Bool(Bool)
    case Value(String)
    case String(String)
    case Key(String)
    
    case WhiteSpace
    case Comma
    case Colon
    case DoubleQuotation
    
    case LeftBrace
    case RightBrace
    
    case LeftBraket
    case RightBraket
    
    func getValue() -> String {
        switch self {
        case .List(_):
            return "배열"
        case .Object(_):
            return "객체"
        case .Number(let value):
            return "\(value)"
        case .Bool(let value):
            return "\(value)"
        case .String(let value):
            return "\(value)"
        case .Key(let value):
            return "\(value)"
        case .WhiteSpace:
            return " "
        case .Colon:
            return ":"
        case .Comma:
            return ","
        case .DoubleQuotation:
            return "\""
        case .LeftBrace:
            return "{"
        case .RightBrace:
            return "}"
        case .LeftBraket:
            return "["
        case .RightBraket:
            return "]"
        case .Value(let value):
            return "\(value)"
        }
    }
    
    func isSameType(_ token: Token) -> Bool {
        switch (self,token) {
        case (.List(_),.List(_)):
            return true
        case (.Number(_),.Number(_)):
            return true
        case (.Bool(_),.Bool(_)):
            return true
        case (.String(_),.String(_)):
            return true
        case (.Key(_),.Key(_)):
            return true
        default:
            return self == token
        }
    }
}


