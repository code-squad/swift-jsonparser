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
    
    private let tokens: [Token]
    private var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    // 토큰이 남았는지 확인 및 토큰 반환
    private func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        
        let token = tokens[position]
        position += 1
        return token
    }
    
    func parse() throws -> JSONData {
        typealias JSONAllowedData = (numbers: [Int], characters: [String], booleans: [Bool])
        var jsonAllowedData: JSONAllowedData = ([], [], [])
        
        while let token = getNextToken() {
            switch token {
            case .list(let tokenList):
                let list: JSONAllowedData = getList(tokenList)
                jsonAllowedData.numbers += list.numbers
                jsonAllowedData.characters += list.characters
                jsonAllowedData.booleans += list.booleans
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        
        return JSONData(jsonAllowedData.numbers, jsonAllowedData.characters, jsonAllowedData.booleans)
    }
    
    private func getList(_ tokens: [Token]) -> ([Int], [String], [Bool]) {
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
