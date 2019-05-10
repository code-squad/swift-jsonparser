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
enum LexicalType: String, CustomStringConvertible{
    case intNumber = "Int"
    case bool = "Bool"
    case string = "String"
    
    var description: String {
        switch self {
        case .intNumber :
            return "숫자"
        case .string :
            return "문자열"
        case .bool :
            return "부울"
        }
    }
}

typealias LexPair = (type: LexicalType , content: String)

struct Lexer {
    static func analyzeLexing (tokenList : [String]) throws -> [LexPair]{
        var result = [LexPair]()
        for token in tokenList {
            let testStringResult = isString(token)
            let testNumberResult = isNumeric(token)
            let testBooleanResult = isBoolean(token)
            let lexicalType = try decideElementLexicalType(string: testStringResult, number: testNumberResult, bool: testBooleanResult)
            result.append(LexPair(type: lexicalType, content: token))
        }
        return result
    }

    static private func decideElementLexicalType( string: Bool, number: Bool, bool : Bool) throws -> LexicalType {
        var result: LexicalType? = string ? LexicalType.string : nil
        result = number ? LexicalType.intNumber : result
        result = bool ? LexicalType.bool : result
        guard let resultType = result else {
            throw ErrorCode.lexicalTypeError
        }
        return resultType
    }
    
    static private func isString (_ token : String) -> Bool {
        return token.hasPrefix("\"") && token.hasSuffix("\"") ? true : false
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
}
