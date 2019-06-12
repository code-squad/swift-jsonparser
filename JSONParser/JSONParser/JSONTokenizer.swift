//
//  JSONTokenizer.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONTokenizer {
    private let tokens: [Character] = [Token.beginArray, Token.endArray, Token.valueSeparator]
    private var result = [String]()
    private var buffer = ""
 
    mutating func tokenize(data: String) throws -> [String] {
        for character in data {
            readToken(character: character)
        }
        return result
    }
    
    private mutating func readToken(character: Character) {
        if tokens.contains(character) {
            appendBuffer()
            result.append(String(character))
        } else {
            buffer.append(character)
        }
    }
    
    private mutating func appendBuffer(){
        if !buffer.isEmpty {
            result.append(buffer.trimmingCharacters(in:[" "]))
            buffer.removeAll()
        }
    }
    
}
