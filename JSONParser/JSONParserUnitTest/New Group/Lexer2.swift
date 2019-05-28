//
//  Lexer2.swift
//  JSONParserUnitTest
//
//  Created by hw on 27/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation


struct Lexer2 {
    
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
    
    static func isString (_ token : String) -> Bool {
        return token.hasPrefix(TokenSplitSign.quatation.description)
            && token.hasSuffix(TokenSplitSign.quatation.description) ? true : false
    }
    
    static func isNumeric (_ token : String) -> Bool {
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
