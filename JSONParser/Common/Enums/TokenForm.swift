//
//  TokenCapsule.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 5. 11..
//  Copyright © 2018년 JK. All rights reserved.
//

enum TokenForm {
    case openBracket
    case closeBracket
    case openBrace
    case closeBrace
    case colon
    case comma
    case quotes
    
    var char: Character{
        switch self {
            case .openBracket:
                return "["
            case .closeBracket:
                return "]"
            case .openBrace:
                return "{"
            case .closeBrace:
                return "}"
            case .colon:
                return ":"
            case .comma:
                return ","
            case .quotes:
                return "\""
        }
    }
    
    var str: String {
        switch self {
            case .openBracket:
                return "["
            case .closeBracket:
                return "]"
            case .openBrace:
                return "{"
            case .closeBrace:
                return "}"
            case .colon:
                return ":"
            case .comma:
                return ","
            case .quotes:
                return "\""
        }
    }
    

}
