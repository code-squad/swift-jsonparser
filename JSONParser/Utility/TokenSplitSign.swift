//
//  TokenSplitSignal.swift
//  JSONParser
//
//  Created by hw on 25/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum TokenSplitSign : String{
    case semicolon = "#"
    case comma = "@"
    case quatation = "\""
    case whitespace = "&"
    case squareBracketStart = "^[^"
    case squareBracketEnd = "$]$"

    case curlyBracketStart = "^{^"
    case curlyBracketEnd = "$}$"
    
    
}
