//
//  Lexer.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 17..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum Token {
    case number(Int)
    case characters(String)
    case boolean(Bool)
    case list(Array<Token>)
}

class Lexer {
    enum Error: Swift.Error {
        case invalidCharacter(Character)
        case invalidBooleanCharacter
    }
    
    private let input: String
    private var position: String.Index
    private let openBracket: Character = "["
    private let closeBracket: Character = "]"
    private let comma: Character = ","
    private let space: Character = " "
    
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
    
    func lex() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            // array판단
            case openBracket:
                // array가져오기
                advance()
                let list: [Token] = try makeListToken()
                tokens.append(.list(list))
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }
        
        return tokens
    }
    
    // 배열일 경우 배열의 토큰 생성
    private func makeListToken() throws -> [Token] {
        var listToken = [Token]()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0"..."9":
                // 숫자 문자가 등장하면 나머지숫자가져오기
                let value: Int = getNumber()
                listToken.append(.number(value))
            case space, comma:
                advance()
            case "\"":
                advance() // 큰따옴표 뒤부터 문자열
                let characters: String = getCharacters()
                listToken.append(.characters(characters))
                advance() // 닫는 따옴표 뒤로 이동
            case "f", "t":
                guard let booleans: Bool = getBooleans() else {
                    throw Lexer.Error.invalidBooleanCharacter
                }
                listToken.append(.boolean(booleans))
                advance()
            case closeBracket:
                advance()
                return listToken
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }
        
        return listToken
    }
    
    private func getNumber() -> Int {
        var value = 0
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0"..."9":
                let digitValue = Int(String(nextCharacter))!
                value = 10 * value + digitValue
                advance()
            default:
                return value
            }
        }
        
        return value
    }
    
    private func getCharacters() -> String {
        var characters: String = ""
        while let nextCharacter = peek() {
            // 닫는 따옴표를 만나기전까지 문자열로 저장
            switch nextCharacter {
            case "\"":
                return characters
            default:
                characters += String(nextCharacter)
                advance()
            }
        }
        
        return characters
    }
    
    // t 또는 f는 'e'가 나올때까지 읽는다.
    private func getBooleans() -> Bool? {
        var booleanText: String = ""
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "e":
                booleanText += String(nextCharacter)
                return Bool(booleanText)
            default:
                booleanText += String(nextCharacter)
                advance()
            }
        }
        
        return Bool(booleanText)
    }
}
