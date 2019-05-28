//
//  Tokenizer.swift
//  JSONParser
//
//  Created by 이진영 on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    static func tokenize(input: String) throws -> [String] {
        guard input.first == "[", input.last == "]" else {
            throw TypeError.unsupportedType
        }
        
        let arrayToken: [Character] = ["[", "]", ",", " ", "\""]
        
        var rawToken = ""
        var rawTokens: [String] = []
        
        for value in input {
            if arrayToken.contains(value) {
                rawTokens.append(rawToken)
                rawTokens.append(String(value))
                
                rawToken.removeAll()
            } else {
                rawToken.append(value)
            }
        }
        
        let tokens = rawTokens.filter { $0 != "" }
        
        return tokens
    }
}
