//
//  Token.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Token {
    case Array
    
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
   
    static let symbols: Array<Token> = [.Comma,.Colon,.DoubleQuotation,.LeftBrace,.RightBrace,.WhiteSpace,.LeftBraket,.RightBraket]
    
}

