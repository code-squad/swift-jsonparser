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
        var temp = ""
        var tokens = Array<String>()
        let mark: [Character] = ["[","]","\"",","]
        
        func tempToTokens() {
            tokens.append(temp)
            temp.removeAll()
        }
        
        for character in input {
            if mark.contains(character) {
                tempToTokens()
                tokens.append(String(character))
            }
            else {
                temp.append(character)
            }
        }
        tempToTokens()
        return tokens
    }
}
