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
        case scanStringFailed
        case scanNumberFailed
        case scanBoolFailed
        
        var localizedDescription: String {
            switch self {
            case .invalidCharacter(let character):
                return "유효하지 않은 문자 \(character)가 입력되었습니다."
            case .scanStringFailed:
                return "String 값 스캔에 실패하였습니다."
            case .scanNumberFailed:
                return "Number 값 스캔에 실패하였습니다."
            case .scanBoolFailed:
                return "Bool 값 스캔에 실패하였습니다."
            }
        }
    }
    
    private let input: String
    private(set) var position: String.Index
    
    init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    mutating func tokenize() throws -> [Token] {
        var tokens = [Token]()
        
        while let token = try nextToken() {
            tokens.append(token)
        }
        
        return tokens
    }
    
    private mutating func nextToken() throws -> Token? {
        guard let nextCharacter = peek() else {
            return nil
        }
        switch nextCharacter {
        case Keyword.openSquareBracket:
            advance()
            return .openSquareBracket
        case Keyword.closeSquareBracket:
            advance()
            return .closeSquareBracket
        case Keyword.comma:
            advance()
            return .comma
        case Keyword.whiteSpace:
            advance()
            return nil
        case Keyword.doubleQuotation:
            let value = try getString()
            let trimmed = try removeDoubleQoutations(value)
            return .string(trimmed)
        case Keyword.true.first, Keyword.false.first:
            let value = try getBool()
            return .bool(value)
        case _ where nextCharacter.isNumber:
            let value = try getNumber()
            return .number(value)
        default:
            throw Lexer.Error.invalidCharacter(nextCharacter)
        }
    }
    
    private func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    private mutating func advance() {
        position = input.index(after: position)
    }
    
    private mutating func removeDoubleQoutations(_ value: String) throws -> String {
        if value.first == Keyword.doubleQuotation && value.last == Keyword.doubleQuotation {
            return String(value.dropFirst().dropLast())
        }
        throw Lexer.Error.scanStringFailed
    }
    
    private mutating func getString() throws -> String {
        var value = ""
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case _ where nextCharacter.isLetter
                || nextCharacter.isNumber
                || Keyword.doubleQuotation == nextCharacter:
                let stringValue = String(nextCharacter)
                value = value + stringValue
                advance()
            default:
                return value
            }
        }
        throw Lexer.Error.scanStringFailed
    }
    
    private mutating func getNumber() throws -> Int {
        let value = try getString()
        if let numberValue = Int(value) {
            return numberValue
        }
        throw Lexer.Error.scanNumberFailed
    }
    
    private mutating func getBool() throws -> Bool {
        let value = try getString()
        if let boolValue = Bool(value) {
            return boolValue
        }
        throw Lexer.Error.scanBoolFailed
    }
}
