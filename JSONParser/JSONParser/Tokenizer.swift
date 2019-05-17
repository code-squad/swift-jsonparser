//
//  Tokenizer.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    
    static let openBracket = "["
    static let closedBracke = "]"
    
    static func execute(using input: String) -> [String] {
        
        let tokens = input.components(separatedBy: [" ", ","])
        
        return tokens.filter(){ token in token != "" }
        
    }
    
}
