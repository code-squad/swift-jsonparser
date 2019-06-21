//
//  Tokenizer.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    
    private var temp = ""
    private var tokens = [String]()

    
    private mutating func tempToTokens() {
        if !temp.isEmpty {
            tokens.append(temp)
            temp.removeAll()
        }
    }
    
    
    mutating func tokenize(input: String) -> [String] {
        
        let structures: [Character] = ["[","]",","]
        var isString = false // "를 만나야 string이기때문에 기본값은 false
        
        for character in input {
            
            if character == "\"" {
                isString.toggle()
            }
            
            if isString {
                temp.append(character)
            } else {
                guard character != " " else {
                    continue
                }
                if structures.contains(character) {
                    tempToTokens()
                    tokens.append(String(character))
                } else {
                    temp.append(character)
                }
            }
            
        }
        tempToTokens()
        return tokens
    }
}

