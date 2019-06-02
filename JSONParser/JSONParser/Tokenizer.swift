//
//  Tokenizer.swift
//  JSONParser
//
//  Created by CHOMINJI on 19/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {

    static func tokenize(from prompt: String) -> [String] {
        var token: String = ""
        var tokens: [String] = []
        
        var isInString = false
        let delimiters = [JSONKeyword.whiteSpace, JSONKeyword.comma].map { Character($0) }
        let brackets = [JSONKeyword.leftCurlyBracket, JSONKeyword.leftSquareBracket, JSONKeyword.rightSquareBracket, JSONKeyword.rightCurlyBracket]
            .map { Character($0) }
        
        for character in prompt {
            
            guard !brackets.contains(character) else {
                tokens.append(String(character))
                continue
            }
            
            if character == Character(JSONKeyword.quotation) {
                isInString.toggle()
            }
            
            guard !isInString else {
                token.append(character)
                continue
            }

            guard delimiters.contains(character) else {
                token.append(character)
                continue
            }

            tokens.append(token)
            token = ""
        }
        
        let trimmedTokens = removeAllWhiteSpaces(in: tokens)
        return trimmedTokens
    }
    
    static private func removeAllWhiteSpaces(in tokens: [String]) -> [String] {
        return tokens.filter { !$0.isEmpty }
    }
}
