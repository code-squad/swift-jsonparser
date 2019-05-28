//
//  Token.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Token {
    case Array(Array<Any>)
    
    case Number(Int)
    case Bool(Bool)
    case Value(String)
    case String(String)
    
    case WhiteSpace
    case Comma
    case DoubleQuotation
    
    case LeftBraket
    case RightBraket
    
}

