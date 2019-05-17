//
//  Tokenizer.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    
    static func execute(using input: String) throws -> [String] {
        
        let tokens = input.components(separatedBy: [" ", ","])
        let validTokens = tokens.filter(){ token in token != "" }
        
        if validTokens.isEmpty { throw TokenizerError.impossibleToTokenize }
        return tokens.filter(){ token in token != "" }
        
    }
    
}
