//
//  Tokenizer.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    static let emptyString = ""
    static let blankWithComma = " ,"
    
    static func execute(using input: String) throws -> [String] {
        let blankAddedInput = input.replacingOccurrences(of: JSONSymbols.comma, with: blankWithComma)
        let tokens = blankAddedInput.components(separatedBy: JSONSymbols.blank)
        if tokens.isEmpty { throw JSONError.impossibleToTokenize }
        return tokens
    }
    
}
