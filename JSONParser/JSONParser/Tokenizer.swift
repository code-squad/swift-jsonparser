//
//  Tokenizer.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Mark {
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
        
        let marks: [Character] = [Mark.startArray, Mark.endArray, Mark.comma, Mark.quotationMark]
        /// 현재 읽고있는 문자가 문자열인지에 대한 상태
        var isString = false
        
        for character in input {
            // 문자열이 아니면 공백을 무시하도록함
            if character == Mark.quotationMark {
                isString.toggle()
            } else if !isString {
                guard character != Mark.whitespace else { continue }
            }
            
            if marks.contains(character) {
                tempToTokens()
                tokens.append(String(character))
            } else {
                temp.append(character)
            }
            
        }
        tempToTokens()
        // 반환하기전에 tokens배열을 비워줌
        let result = tokens
        tokens.removeAll()
        return result
    }
}

