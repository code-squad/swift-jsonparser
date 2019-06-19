//
//  Lexer.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct Lexer {
    
    enum Error: Swift.Error {
        case invalidCharacter(Character)
        
        var localizedDescription: String {
            switch self {
            case .invalidCharacter(let character):
                return "유효하지 않은 문자 \(character)가 입력되었습니다."
            }
        }
    }
    
    private let delimeterTokenList: [Character: Token] = [
        Keyword.openCurlyBracket: .openCurlyBracket,
        Keyword.closeCurlyBracket: .closeCurlyBracket,
        Keyword.openSquareBracket: .openSquareBracket,
        Keyword.closeSquareBracket: .closeSquareBracket,
        Keyword.comma: .comma,
        Keyword.colon: .colon
    ]
    private var stringReader: StringReader
    
    init(stringReader: StringReader) {
        self.stringReader = stringReader
    }
    
    mutating func tokenize() throws -> [Token] {
        var tokens = [Token]()
        
        while let token = try nextToken() {
            tokens.append(token)
        }
        
        return tokens
    }
    
    private mutating func nextToken() throws -> Token? {
        guard let nextCharacter = stringReader.peek() else {
            return nil
        }
        
        skipWhiteSpaces()
        
        if let token = delimeterTokenList[nextCharacter] {
            stringReader.advance()
            return token
        }
        
        if nextCharacter.isAlphanumeric {
            let string = getString()
            
            if let number = Int(string) {
                return .number(number)
            }
            
            switch string {
            case Keyword.true: return .true
            case Keyword.false: return .false
            default: throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }
        
        let string = getString()
        let word = StringUtility.removeDoubleQuotations(string)
        return .string(word)
    }
    
    private mutating func skipWhiteSpaces() {
        while let nextCharacter = stringReader.peek() {
            if !nextCharacter.isWhitespace {
                break
            }
            stringReader.advance()
        }
    }
    
    private mutating func getString() -> String {
        var value = ""
        while let nextCharacter = stringReader.peek(),
            nextCharacter.isAlphanumeric || nextCharacter == Keyword.doubleQuotation {
                value = value + String(nextCharacter)
                stringReader.advance()
        }
        return value
    }
}

extension Character {
    var isAlphanumeric: Bool {
        return self.isLetter || self.isNumber
    }
}
