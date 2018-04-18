//
//  Parser.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Parser {
    
    enum Error: Swift.Error {
        case unexpectedEndOfInput
        case invalidToken(Token)
    }
    
    let tokens: [Token]
    var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    // 토큰이 남았는지 확인 및 토큰 반환
    func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        
        let token = tokens[position]
        position += 1
        return token
    }
    
    func parse() throws -> JSONData {
        typealias Data = (numbers: [Int], characters: [String], booleans: [Bool])
        var data: Data = ([], [], [])
        
        while let token = getNextToken() {
            switch token {
            case .list(let tokens):
                let list: Data = getList(tokens)
                data.numbers += list.numbers
                data.characters += list.characters
                data.booleans += list.booleans
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        
        return JSONData(numbers: data.numbers, characters: data.characters, booleans: data.booleans)
    }
    
    func getList(_ tokens: [Token]) -> ([Int], [String], [Bool]) {
        var numbers: [Int] = [Int]()
        var characters: [String] = [String]()
        var booleans: [Bool] = [Bool]()
        
        for token in tokens {
            switch token {
            case .boolean(let value):
                booleans.append(value)
            case .characters(let value):
                characters.append(value)
            case .number(let value):
                numbers.append(value)
            default:
                break
            }
        }
        
        return (numbers, characters, booleans)
    }
}
