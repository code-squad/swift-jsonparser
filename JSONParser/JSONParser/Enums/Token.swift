//
//  Token.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Token{
    case Array(Array<Any>)
    
    case Number(Int)
    case Bool(Bool)
    case Value(String)
    case String(String)
    
    case WhiteSpace
    case Comma
    case DoubleQuotes
    
    case LeftBraket
    case RightBraket
    
}

extension Token: Equatable {
    static func == (lhs: Token, rhs: Token) -> Bool {
        var equal = false
        
        switch (lhs,rhs){
        case let (.Number(a),.Number(b)):
            equal = a == b
        case let (.Bool(a),.Bool(b)):
            equal = a == b
        case let (.String(a),.String(b)):
            equal = a == b
        case let (.Value(a),.Value(b)):
            equal = a == b
        case (.WhiteSpace,.WhiteSpace):
            equal = true
        case (.Comma,.Comma):
            equal = true
        case (.DoubleQuotes,.DoubleQuotes):
            equal = true
        case (.LeftBraket,.LeftBraket):
            equal = true
        case (.RightBraket,.RightBraket):
            equal = true
        default :
            ()
        }
        return equal
    }
}
