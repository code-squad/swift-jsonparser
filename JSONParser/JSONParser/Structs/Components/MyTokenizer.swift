//
//  MyTokenizer.swift
//  JSONParser
//
//  Created by 이동영 on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MyTokenizer: Tokenizer {
    
    static func tokenize(string: String) throws -> [Token] {
        let factory = TokenFactory()
        let units = self.split(string)
        let tokens = try units.map{
            try factory.create(string: $0)
        }
        return tokens
    }
    
    private static func split(_ string: String) -> [String] {
        let pattern = Pattern.tokens
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: string, options: [], range: string.range)
        let units = matches.map {
            NSString.init(string: string).substring(with: ($0.range))
        }
        return units
    }
}
