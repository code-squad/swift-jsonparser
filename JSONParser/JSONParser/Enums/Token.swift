//
//  Token.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum Token: String {
    case Array = "배열"
    
    case Number = "숫자"
    case Bool = "부울"
    case Value = "값"
    case String = "문자열"
    
    case WhiteSpace = "공백"
    case Comma = "콤마"
    case DoubleQuotation = "쌍따옴표"
    
    case LeftBraket = "대괄호(좌)"
    case RightBraket = "대괄호(우)"
    
    static let symbols: Array<Token> = [.Comma,.DoubleQuotation,.WhiteSpace,.LeftBraket,.RightBraket]
    
}

