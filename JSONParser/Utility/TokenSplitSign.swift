//
//  TokenSplitSignal.swift
//  JSONParser
//
//  Created by hw on 25/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum TokenSplitSign : CustomStringConvertible{
    case semicolon 
    case comma
    case quatation
    case whitespace
    
    case squareBracketStart
    case squareBracketEnd
    case curlyBracketStart
    case curlyBracketEnd
    var description: String {
        switch self{
        case .semicolon:
            return ":"
        case .comma:
            return ","
        case .quatation:
            return "\""
        case .whitespace :
            return " "
        case .squareBracketStart:
            return "["
        case .squareBracketEnd:
            return "]"
        case .curlyBracketStart:
            return "{"
        case .curlyBracketEnd:
            return "}"
            
        }
        
    }
    
}
