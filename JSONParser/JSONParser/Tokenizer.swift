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
    
    static func execute(using input: String) throws -> [String] {
        var tokenDivider = CharacterSet(charactersIn: JSONSymbols.comma)
        tokenDivider.insert(charactersIn: JSONSymbols.blank)
        let tokens = input.components(separatedBy: tokenDivider)
        let validTokens = tokens.filter(){ token in token != emptyString }
        
        if validTokens.isEmpty { throw TokenizerError.impossibleToTokenize }
        return tokens.filter(){ token in token != emptyString }
        
    }
    
}
