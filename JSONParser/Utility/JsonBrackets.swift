//
//  JsonBrackets.swift
//  JSONParser
//
//  Created by hw on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation


enum JsonBrackets: String  {
    
    case StartCurlyBrace = "{"
    case EndCurlyBrace = "}"
    case StartSquareBracket = "["
    case EndSquareBracket = "]"

    
    var characterSymbol: Character {
        switch self {
        case .StartCurlyBrace:
            return "{"
        case .EndCurlyBrace:
            return "}"
        case .StartSquareBracket:
            return "["
        case .EndSquareBracket:
            return "]"
        }
    }
}
