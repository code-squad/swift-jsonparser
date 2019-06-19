//
//  Tokenizer.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    
    func tokenize(input: String) -> [String] {
        let splitedInputs = Array(input.split(separator: ","))
        
        var tokens = Array<String>()
        
        for index in 0 ..< splitedInputs.count {
            tokens.append(String(splitedInputs[index]))
            tokens.append(",")
        }
            tokens.removeLast()
        
        if tokens[0].first == "[" {
            tokens[0].removeFirst()
            tokens.insert("[", at: 0)
        }
        
        if tokens[tokens.count-1].last == "]" {
            tokens[tokens.count-1].removeLast()
            tokens.insert("]", at: tokens.count)
        }
        
        return tokens
    }
}
