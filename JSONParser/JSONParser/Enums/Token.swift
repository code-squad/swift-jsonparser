//
//  Token.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Token{
    case Number(Int)
    case Bool(Bool)
    case String(String)
    
    case WhiteSpace
    case Comma
    
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
        case (.WhiteSpace,.WhiteSpace):
            equal = true
        case (.Comma,.Comma):
            equal = true
        default :
            ()
        }
        return equal
    }
}
