//
//  Tokenizer.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//
// https://stackoverflow.com/questions/380455/looking-for-a-clear-definition-of-what-a-tokenizer-parser-and-lexers-are
// A tokenizer breaks a stream of text into tokens, usually by looking for whitespace (tabs, spaces, new lines).
// A lexer is basically a tokenizer, but it usually attaches extra context to the tokens -- this token is a number, that token is a string literal, this other token is an equality operator.
// A parser takes the stream of tokens from the lexer and turns it into an abstract syntax tree representing the (usually) program represented by the original text.
import Foundation

struct Tokenizer {
    
    static  func tokenize (_ input: String ) -> [String] {
        let lowerBound = String.Index.init(encodedOffset: 1)
        let uppderBound = String.Index.init(encodedOffset: input.count-1)
        let removeSquareBracketInput = input[lowerBound..<uppderBound]
        let output = removeSquareBracketInput.split(separator: ",").map { (value) in return String(value).trimmingCharacters(in: .whitespacesAndNewlines)}
        return output
    }
}
