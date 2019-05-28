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
        let blankAddedData = jsonData.replacingOccurrences(of: JSONSymbols.comma.rawValue, with: commaWithBlank)
        let tokens = try tokenize(blankAddedData)
        if tokens.isEmpty { throw TokenizerError.impossibleToTokenize }
        return tokens
    }
    
    private static func tokenize(_ jsonData: String) throws -> [String] {
        var tokens = [String]()
        var token = String()
        var isOutOfString = true
        
        for character in jsonData {
            if JSONSymbols.doubleQuotation.equals(character) {
                isOutOfString.toggle()
            }
            if JSONSymbols.blank.equals(character) && isOutOfString {
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
