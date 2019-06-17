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
        if !scanError(at: input) {
            throw TypeError.unsupportedType
        }
        
        let baseToken: [Character] = JsonElement.baseToken
        
        var rawToken = ""
        var rawTokens: [String] = []
        
        for value in input {
            if baseToken.contains(value) {
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
    
    private static func scanError(at input: String) -> Bool {
        guard let first = input.first, let last = input.last else {
            return false
        }
        
        guard JsonElement.supportType.contains(first), JsonElement.supportType.contains(last) else {
            return false
        }
        
        return true
    }
}
