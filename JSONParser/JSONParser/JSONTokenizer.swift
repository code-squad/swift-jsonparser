//
//  JSONTokenizer.swift
//  JSONParser
//
//  Created by JieunKim on 05/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONTokenizer {
    static func tokenize(data: String) throws -> [String] {
        let tokens: [Character] = [Token.beginArray, Token.endArray, Token.valueSeparator]
        var result = [String]()
        var buffer = ""
        
        func appendBuffer(){
            if !buffer.isEmpty {
                result.append(buffer)
                buffer.removeAll()
            }
        }
        
        func readToken(character: Character) {
            if tokens.contains(character) {
               appendBuffer()
                result.append(String(character))
            } else {
                buffer.append(character)
            }
        }
        
        for character in data {
            readToken(character: character)
        }
        appendBuffer()
        return result
    }
}


