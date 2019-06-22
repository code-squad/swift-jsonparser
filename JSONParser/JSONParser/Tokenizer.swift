//
//  Tokenizer.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Structure {
    static let startArray: Character = "["
    static let endArray: Character = "]"
    static let comma: Character = ","
    static let quotationMark: Character = "\""
    static let whitespace: Character = " "
}

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
        
        let structures: [Character] = [Structure.startArray, Structure.endArray, Structure.comma]
        var isString = false //"이 나와야 string이기때문에 그 전까지 기본값은 false
        
        for character in input {
            
            if character == Structure.quotationMark { //""안에서는 문자를 나누지 않도록 조건을 설정함
                isString.toggle()
            }
            
            if isString {
                temp.append(character)
            } else {
                guard character != Structure.whitespace else { //공백은 무시하고 다음 루프로 이동함
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
        // 반환하기전에 tokens배열을 비워줌
        let result = tokens
        tokens.removeAll()
        return result
    }
}

