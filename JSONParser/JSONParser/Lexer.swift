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
    
    private func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    private mutating func advance() {
        position = input.index(after: position)
    }
    
    private mutating func skipDoubleQuotes() throws {
        if let nextCharacter = peek(), nextCharacter != "\"" {
            throw Lexer.Error.invalidCharacter(nextCharacter)
        }
        advance()
    }
    
    private mutating func getString() throws -> String {
        var value = ""
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "a" ... "z", "0" ... "9" :
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
    
    mutating func tokenize() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "[":
                tokens.append(.openSquareBracket)
                advance()
            case "]":
                tokens.append(.closeSquareBracket)
                advance()
            case "\"":
                advance()
                let value = try getString()
                tokens.append(.string(value))
                try skipDoubleQuotes()
            case "t", "f":
                let value = try getBool()
                tokens.append(.bool(value))
            case "0" ... "9":
                let value = try getNumber()
                tokens.append(.number(value))
            case ",":
                tokens.append(.comma)
                advance()
            case " ":
                advance()
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }
        return tokens
    }
}
