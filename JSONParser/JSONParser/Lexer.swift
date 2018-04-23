//
//  JSONLexer.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

// parser에게 token을 넘겨주는 역할
// lexer 의 첫 번째 것으로 판단 하는 것을 보고 Queue를 이용
struct Lexer {
    
    private var lexer: Queue<Character>
    
    init(_ lexerFormat: String) {
        self.lexer = Queue(Array(lexerFormat.trim()))
    }
    
    func getToken() throws -> Queue<String> {
        let tokens = Queue<String>()
        var tokenValue : String = ""
        
        while let token = lexer.dequeue() {
            switch token {
                case TokenSplitUnit.startBracket.rawValue:
                    tokens.enqueue(String(token))
                case TokenSplitUnit.endBrackert.rawValue:
                    tokens.enqueue(tokenValue)
                    tokens.enqueue(String(token))
                case TokenSplitUnit.comma.rawValue:
                    tokens.enqueue(tokenValue)
                    tokens.enqueue(String(token))
                    tokenValue.removeAll()
            default:
                tokenValue += String(token)
            }
        }
        
        if tokens.isEmpty() {
            throw JSONPaserErorr.isJsonLexer
        }
        
        return tokens
    }
}
