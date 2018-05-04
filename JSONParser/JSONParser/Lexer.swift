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
    private let tokens: Queue<String>
    
    init(_ lexerFormat: String) {
        self.lexer = Queue(Array(lexerFormat.trim()))
        self.tokens = Queue<String>()
    }
    
    func getToken() throws -> Queue<String> {
        var tokenValue : String = ""
        
        while let token = lexer.dequeue() {
            switch token {
                case TokenSplitUnit.startBracket.char:
                    tokens.enqueue(String(token))
                case TokenSplitUnit.endBrackert.char:
                    tokenValue = setTokenValue(tokenValue)
                    tokens.enqueue(String(token))
                case TokenSplitUnit.startBrace.char:
                    tokens.enqueue(String(token))
                case TokenSplitUnit.endBrace.char:
                    tokenValue = setTokenValue(tokenValue)
                    tokens.enqueue(String(token))
                case TokenSplitUnit.comma.char:
                    tokenValue = setTokenValue(tokenValue)
                    tokens.enqueue(String(token))
            default:
                tokenValue += String(token)
            }
        }
        
        if tokens.isEmpty() {
            throw JSONPaserErorr.isJsonLexer
        }
        return tokens
    }
    
    private func setTokenValue(_ tokenValue: String) -> String {
        if !tokenValue.isEmpty {
            tokens.enqueue(tokenValue)
            return ""
        }
        return tokenValue
    }
}
