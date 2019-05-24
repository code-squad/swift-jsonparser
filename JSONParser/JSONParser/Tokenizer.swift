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
    
    private let input: String
    
    init(input: String) {
        self.input = input.replacingOccurrences(of: JSONSymbols.comma.rawValue, with: Tokenizer.commaWithBlank)
    }
    
    func execute() throws -> [String] {
        let tokens = try tokenize()
        if tokens.isEmpty { throw JSONError.impossibleToTokenize }
        return tokens
    }
    
    private func tokenize() throws -> [String] {
        var tokens = [String]()
        var token = String()
        var isOutOfString = true
        
        for index in input.indices {
            let character = input[index]
            if JSONSymbols.doubleQuotation.equals(character) {
                isOutOfString = !isOutOfString
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
