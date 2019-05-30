//
//  JSONSymbols.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONSymbols {
    static let openBracket: Character = "["
    static let closedBracket: Character = "]"
    static let openBrace: Character = "{"
    static let closedBrace: Character = "}"
    static let comma: Character = ","
    static let blank: Character = " "
    static let doubleQuotation: Character = "\""
    static let colon: Character = ":"
}

extension Character {
    var inString: String {
        return String(self)
    }
}

