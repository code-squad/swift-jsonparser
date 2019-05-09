//
//  Parser.swift
//  JSONParser
//
//  Created by hw on 08/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//
// A parser takes the stream of tokens from the lexer and turns it into an abstract syntax tree representing the (usually) program represented by the original text.
import Foundation

struct Parser {
    
    static func parseLexerResult (_ lexPair: [LexPair] ) -> JsonDictionary{
        
        var dictionaryResult = JsonDictionary()
        for element in lexPair{
            dictionaryResult.jsonElements[element.type]?.append(element.content)
        }
        return dictionaryResult
    }
    
    static func updateDictionary( dictionary: inout JsonDictionary, type: LexicalType, element: String )  {
        dictionary.jsonElements[type]?.append(element)
    }
}
