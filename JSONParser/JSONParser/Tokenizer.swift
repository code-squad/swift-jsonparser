//
//  Tokenizer.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Tokenizer {
    static let commaWithBlank = " ,"
    
    static func execute(jsonData: String) throws -> [String] {
        let blankAddedData = jsonData.replacingOccurrences(of: JSONSymbols.comma.inString, with: commaWithBlank)
        let tokens = tokenize(blankAddedData)
        if tokens.isEmpty { throw TokenizerError.impossibleToTokenize }
        return tokens
    }
    
    private static func tokenize(_ jsonData: String) -> [String] {
        var tokens = [String]()
        var token = String()
        var isOutOfString = true
        
        for character in jsonData {
            if JSONSymbols.doubleQuotation == character {
                isOutOfString.toggle()
            }
            if JSONSymbols.blank == character && isOutOfString {
                tokens.append(token)
                token = String()
                continue
            }
            token += String(character)
        }
        tokens.append(token)
        return tokens
    }
    
}
