//
//  Lexer.swift
//  JSONParser
//
//  Created by hw on 08/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

// A lexer is basically a tokenizer, but it usually attaches extra context to the tokens -- this token is a number,
// that token is a string literal, this other token is an equality operator.
// https://www.quora.com/Whats-the-difference-between-a-tokenizer-lexer-and-parser
// A lexer does the same plus attachs extra information to each token. If we tokenize into words,
// a lexer would attach tags like number, word, punctuation etc.

import Foundation

struct Lexer {
    
    static func confirmTokenDataType (_ token : String ) throws -> LexicalType {
        if  isNumeric(token) {
            return LexicalType.intNumber
        }
        if isBoolean(token){
            return LexicalType.bool
        }
        if isJsonObject(token) {
            return LexicalType.jsonObject
        }
        if isJsonArray(token) {
            return LexicalType.jsonArray
        }
        if isString(token) {
            return LexicalType.string
        }
        
        throw ErrorCode.lexicalTypeError
    }
    
    static private func isString (_ token : String) -> Bool {
        return token.hasPrefix(TokenSplitSign.quatation.description)
                && token.hasSuffix(TokenSplitSign.quatation.description) ? true : false
    }
    
    static private func isNumeric (_ token : String) -> Bool {
        guard let _: Int = Int(token) else {
            return false
        }
        return true
    }
    
    static private func isBoolean (_ token : String) -> Bool {
        guard let _: Bool = Bool(token) else {
            return false
        }
        return true
    }
    
    static private func isJsonObject (_ token: String) -> Bool {
        return token[0] == TokenSplitSign.curlyBracketStart.description && token[token.count-1] == TokenSplitSign.curlyBracketEnd.description
    }
    
    static private func isJsonArray (_ token: String ) -> Bool {
        return token[0] == TokenSplitSign.squareBracketStart.description && token[token.count-1] == TokenSplitSign.squareBracketEnd.description
    }
    
}
