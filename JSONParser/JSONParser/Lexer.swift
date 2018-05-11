//
//  JSONLexer.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

struct Lexer {

    private let inputQueue: Queue<Character>
    private let lexQueue: Queue<String>
    
    init(_ inputData: String) {
        self.inputQueue = Queue(Array(inputData))
        self.lexQueue = Queue<String>()
    }
    
    func lex() -> Queue<String> {
        var tokenValue: String = ""
        while let token = inputQueue.dequeue() {
            switch token {
                case TokenForm.openBracket.char:
                    lexQueue.enqueue(TokenForm.openBracket.str)
                case TokenForm.closeBracket.char:
                    tokenValue = validTokenValue(tokenValue)
                    lexQueue.enqueue(TokenForm.closeBracket.str)
                case TokenForm.openBrace.char:
                    lexQueue.enqueue(TokenForm.openBrace.str)
                case TokenForm.closeBrace.char:
                    tokenValue = validTokenValue(tokenValue)
                    lexQueue.enqueue(TokenForm.closeBrace.str)
                case TokenForm.colon.char:
                    tokenValue = validTokenValue(tokenValue)
                    lexQueue.enqueue(TokenForm.colon.str)
                case TokenForm.comma.char:
                    tokenValue = validTokenValue(tokenValue)
                    lexQueue.enqueue(TokenForm.comma.str)
            default:
                tokenValue += String(token)
            }
        }
        return lexQueue
    }
    
    private func validTokenValue(_ tokenValue: String) -> String {
        if !tokenValue.isEmpty {
            lexQueue.enqueue(tokenValue)
            return ""
        }
        return tokenValue
    }
}
