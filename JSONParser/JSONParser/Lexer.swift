//
//  Lexer.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 17..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Lexer {
    enum Error: Swift.Error {
        case invalidCharacter(Character)
        case invalidBooleanCharacter
        
        var errorMessage: String {
            switch self {
            case .invalidBooleanCharacter:
                return "Boolean input was wrong!"
            case .invalidCharacter(let character):
                return "Input contained an invalid character: \(character)"
            }
        }
    }
    
    private let input: String
    private var position: String.Index
    private let openBracket: Character = "["
    private let closeBracket: Character = "]"
    private let comma: Character = ","
    private let space: Character = " "
    private let openCurlyBracket: Character = "{"
    private let closeCurlyBracket: Character = "}"
    
    init(input: String) {
        self.input = input
        self.position = input.startIndex
    }
    
    // 입력된 문자를 확인.
    private func peek() -> Character? {
        guard self.position < input.endIndex else {
            return nil
        }
        return input[self.position]
    }
    
    // 다음 문자로 체크하기 위해 index 이동
    private func advance() {
        self.position = self.input.index(after: self.position)
    }
    
    func lex() throws -> Tokenizable {
        var tokens: [String] = [String]()
        var tokenCarrier = "" // valueToken에 의미있는 문자열단위(토큰) 전달
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case comma:
                if tokenCarrier.isEmpty {
                    advance()
                    continue
                }
                tokens.append(tokenCarrier)
                tokenCarrier.removeAll()
            case space:
                break
            case openCurlyBracket, openBracket:
                tokens.append(String(nextCharacter))
                tokenCarrier.removeAll()
            case closeBracket, closeCurlyBracket:
                if !tokenCarrier.isEmpty {
                    tokens.append(tokenCarrier)
                    tokenCarrier.removeAll()
                }
                tokens.append(String(nextCharacter))
            default:
                tokenCarrier += String(nextCharacter)
            }
            advance()
        }
        return Token(tokens: tokens)
    }
}
