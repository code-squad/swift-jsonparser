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
        var isString = false //"이 나와야 string이기때문에 그 전까지 기본값은 false
        
        for character in input {
            
            if character == "\"" { //""안에서는 문자를 나누지 않도록 조건을 설정함
                isString.toggle()
            }
            
            if isString {
                temp.append(character)
            } else {
                guard character != " " else { //공백은 무시하고 다음 루프로 이동함
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

