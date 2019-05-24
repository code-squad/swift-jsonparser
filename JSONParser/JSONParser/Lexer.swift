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
        let testStringResult = isString(token)
        let testNumberResult = isNumeric(token)
        let testBooleanResult = isBoolean(token)
        let testJsonObjectResult = isJsonObject(token)
        let testJsonArrayResult = isJsonArray(token)
        let result = try decideElementLexicalType(string: testStringResult, number: testNumberResult, bool: testBooleanResult,
                                                  jsonObject: testJsonObjectResult, jsonArray: testJsonArrayResult)
        return result
    }
    
    static func checkInputType ( _ input: String) -> LexicalType {
        var type : LexicalType = LexicalType.string
        let trimInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimInput[trimInput.startIndex] == JsonBrackets.StartSquareBracket.characterSymbol &&
            trimInput[trimInput.index(before: trimInput.endIndex)] == JsonBrackets.EndSquareBracket.characterSymbol  {
            type = LexicalType.jsonArray
        }
        if trimInput[trimInput.startIndex] == JsonBrackets.StartCurlyBrace.characterSymbol && trimInput[trimInput.index(before: trimInput.endIndex)] == JsonBrackets.EndCurlyBrace.characterSymbol {
            type = LexicalType.jsonObject
        }
        return type
    }
    
    static private func decideElementLexicalType( string: Bool = false,
                                                  number: Bool = false,
                                                  bool : Bool = false,
                                                  jsonObject: Bool = false,
                                                  jsonArray: Bool = false) throws -> LexicalType {
        var result: LexicalType? = string ? LexicalType.string : nil
        result = number ? LexicalType.intNumber : result
        result = bool ? LexicalType.bool : result
        result = jsonObject ? LexicalType.jsonObject : result
        result = jsonArray ? LexicalType.jsonArray : result
        
        guard let resultType = result else {
            throw ErrorCode.lexicalTypeError
        }
        return resultType
    }
    
    static private func isString (_ token : String) -> Bool {
        return token.hasPrefix(TokenSplitStandard.quatation.rawValue)
                && token.hasSuffix(TokenSplitStandard.quatation.rawValue) ? true : false
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
        return token[0] == JsonBrackets.StartCurlyBrace.rawValue && token[token.count-1] == JsonBrackets.EndCurlyBrace.rawValue
    }
    
    static private func isJsonArray (_ token: String ) -> Bool {
        return token[0] == JsonBrackets.StartSquareBracket.rawValue && token[token.count-1] == JsonBrackets.EndSquareBracket.rawValue
    }
    
}
