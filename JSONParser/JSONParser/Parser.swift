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
    
    func parse() throws {
        while let token = getNextToken() {
            switch token {
            case .list:
                getList()
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
    }
    
    func getList() {
        
    }
}
