//
//  JSONPaser.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

// 규격이 일치하는지
class Paser {
    
    var jsonQueue: Queue<Any> = Queue<Any>()
    var rawArray: Array<Any> = Array<Any>()
    
    private var tokens: Queue<String>
    private var tokenCapsule: Stack<String>
    
    init(_ tokens: Queue<String>) {
        self.tokens = tokens
        self.tokenCapsule = Stack<String>()
    }
    
    func parse() throws -> Array<Any> {
        while let token = tokens.dequeue() {
            switch token {
                case String(TokenSplitUnit.startBracket.rawValue): tokenCapsule.push(token)
                case String(TokenSplitUnit.endBrackert.rawValue): try isMatching(tokenCapsule.pop(), token)
                case String(TokenSplitUnit.comma.rawValue): try isClose(tokens.front())
            default: try setJSONData(token)
            }
        }
        
        if !tokenCapsule.isEmpty() && !jsonQueue.isEmpty() {
            throw JSONPaserErorr.isJsonPaser
        }
        
        return rawArray
    }
    
    private func setJSONData(_ token: String) throws {
        guard let first = token.first else {
            throw JSONPaserErorr.isEmpty
        }
        
        switch first {
            case "0"..."9"          : try setNumber(token)
            case "\""               : try setString(token)
            case "f", "t", "F", "T" : try setBoolean(token)
        default: throw JSONPaserErorr.notFirst
        }
    }
    
    private func isMatching(_ front: String?, _ end: String) throws {
        guard let font = front else {
            throw JSONPaserErorr.isStartBracketCapsule
        }
        
        let capsule = font + end
        
        switch capsule {
            case Capsule.Bracket.rawValue: try setArrayType()
        default: throw JSONPaserErorr.isJsonPaser
        }
    }
    
    private func isClose(_ front: String?) throws {
        guard let front = front else {
            throw JSONPaserErorr.isEmpty
        }
        switch front {
            case String(TokenSplitUnit.endBrackert.rawValue): throw JSONPaserErorr.isEmpty
            case "": throw JSONPaserErorr.isEmpty
            case String(TokenSplitUnit.comma.rawValue): throw JSONPaserErorr.isEmpty
        default: break
        }
    }
    
    private func setNumber(_ numberToken: String) throws {
        try numberToken.pattenMatching(RegexPatten.NumberPatten.rawValue)
        guard let numberToken = Int(numberToken) else {
            throw JSONPaserErorr.isNumber
        }
        jsonQueue.enqueue(numberToken)
    }
    
    private func setString(_ stringToken: String) throws {
        try stringToken.pattenMatching(RegexPatten.StringPatten.rawValue)
        jsonQueue.enqueue(stringToken)
    }
    
    private func setBoolean(_ booleanToken: String) throws {
        try booleanToken.pattenMatching(RegexPatten.BooleanPaten.rawValue)
        guard let booleanTokne = Bool(booleanToken) else {
            throw JSONPaserErorr.isBoolean
        }
        jsonQueue.enqueue(booleanTokne)
    }
    
    // 반환 할 Array타입 생성
    private func setArrayType() throws {
        while let queue = jsonQueue.dequeue() {
            rawArray.append(queue)
        }
        
        // 아직 안 끝났으면 stack에 값을 저장
        if !tokenCapsule.isEmpty() {
            jsonQueue.enqueue(rawArray)
        }
    }

}
