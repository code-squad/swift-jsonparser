//
//  TokenSplitStandard.swift
//  JSONParser
//
//  Created by hw on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum TokenSplitStandard : String{
    case semicolon = ":"
    case comma = ","
    case quatation = "\""
    case whitespace = " "
    var characterSymbol: Character {
        switch self{
        case .comma:
            return ","
        case .quatation:
            return "\""
        case .semicolon:
            return ":"
        case .whitespace:
            return " "
        }
    }
    func isWhiteSpace (_ input: String) -> Bool {
        return true
    }
}
