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
    case text(String)
    case boolean(Bool)
}

struct Lexer {
    enum Error: Swift.Error {
        case invalidCharacter(Character)
    }
    
    let input: String
    var position: String.Index
    
    private let openBracket: Character = "["
    
    init(input: String) {
        self.input = input
        self.position = input.startIndex
    }
    
    // 입력된 문자를 확인.
    func peek() -> Character? {
        guard let self.position < input.endIndex else {
            return nil
        }
        return input[self.position]
    }
    
    // 다음 문자로 체크하기 위해 index 이동
    mutating func advance() {
        assert(self.position < input.endIndex, "Cannot advance past endIndext")
        self.position = self.input.index(after: self.position)
    }
    
    // 실제 토큰을 얻기 위한 lex
    func lex() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = self.peek() {
            switch nextCharacter {
            // array판단
            case openBracket:
                // array가져오기
                getArray()
            default:
                throw Lexer.Error.invalidCharacter(nextCharacter)
            }
        }
        
        return tokens
    }
    
    func getArray() {
        
    }
    
}
