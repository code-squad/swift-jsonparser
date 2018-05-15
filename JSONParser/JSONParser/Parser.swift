////
////  JSONPaser.swift
////  JSONParser
////
////  Created by Jung seoung Yeo on 2018. 4. 19..
////  Copyright © 2018년 JK. All rights reserved.
////

import Foundation

struct Parser {
    private let lexQueue: Queue<String>
    private let tokenCapsule: Stack<String>
    
    init(_ lexQueue: Queue<String>){
        self.lexQueue = lexQueue
        self.tokenCapsule = Stack<String>()
    }
    
    private func isVaildLex() -> Bool {
        return !lexQueue.isEmpty()
    }
    
    func parse() throws -> JSON {
        guard isVaildLex() else {
            throw JsonError.isVilidLex
        }
        return try parseMaker()
    }
    
    private func parseMaker() throws -> JSON {
    
        let lexFront = lexQueue.front()
        
        switch lexFront {
            case TokenForm.openBracket.str:
                if case .array(let arr) =  try arrayMaker() {
                    return arr
                }
                throw JsonError.isStartToken
            case TokenForm.openBrace.str:
                if case .object(let obj) = try objectMaker() {
                    return obj
                }
                throw JsonError.isStartToken
        default:
            throw JsonError.isStartToken
        }
    }
    
    private func arrayMaker() throws -> Type {
        var array: [Type] = []
        
        while let token = lexQueue.dequeue() {
            switch token {
                case TokenForm.openBracket.str:
                    tokenCapsule.push(token)
                    try array.append(arrayMaker())
                case TokenForm.closeBracket.str:
                    try closeCapsule(token)
                    if lexQueue.isEmpty() {
                        break
                    }
                    continue
                case TokenForm.openBrace.str:
                    tokenCapsule.push(token)
                    try array.append(objectMaker())
                case TokenForm.closeBrace.str:
                    try closeCapsule(token)
                    if lexQueue.isEmpty() {
                        break
                    }
                    continue
                case TokenForm.comma.str:
                    if lexQueue.isEmpty() {
                        throw JsonError.isCommaNext
                    }
                    continue
                case TokenForm.colon.str:
                    throw JsonError.isToken
            default:
                try array.append(jsonTypeMaker(token))
            }
        }
        
        try emptyChekcer()
        
        return Type.array(array)
    }
    
    private func objectMaker() throws -> Type {
        var object : [String: Type] = [:]
        var key: String = ""
        
        while let token = lexQueue.dequeue() {
            switch token {
                case TokenForm.openBrace.str:
                    tokenCapsule.push(token)
                    continue
                case TokenForm.closeBrace.str:
                    try closeCapsule(token)
                    return Type.object(object)
                case TokenForm.colon.str:
                    guard let nextToken = lexQueue.dequeue() else {
                        throw JsonError.isNextToken
                    }
                    object[key] = try objectValueMaker(nextToken)
                case TokenForm.comma.str:
                if lexQueue.isEmpty() {
                    throw JsonError.isCommaNext
                }
            default :
                try key = objectKeyMaker(token)
            }
        }
        
        try emptyChekcer()
        
        return Type.object(object)
    }
    
    private func objectKeyMaker(_ token: String) throws -> String {
        guard token.isMatching(expression: NSRegularExpression(pattern: Regex.string.description)) else {
            throw JsonError.isStringMatching
        }
        return token
    }
    
    private func objectValueMaker(_ token: String) throws -> Type {
        switch token {
        case TokenForm.openBracket.str:
            tokenCapsule.push(token)
            return try arrayMaker()
        case TokenForm.openBrace.str:
            tokenCapsule.push(token)
            return try objectMaker()
        default:
            return try jsonTypeMaker(token)
        }
    }

    private func jsonTypeMaker(_ token: String) throws -> Type {
        guard let tokenFirst = token.first else {
            throw JsonError.isTokenFirst
        }
        
        switch tokenFirst {
            case TokenForm.startNumber.char ... TokenForm.endNumber.char:
                return try makeNumber(token)
            case TokenForm.quotes.char:
                return try makeString(token)
            case TokenForm.capitalTrueStart.char,
                 TokenForm.captitalFalseStart.char,
                TokenForm.smallTrueStart.char,
                TokenForm.samllFalseStart.char:
                return try makeBoolean(token)
        default:
            throw JsonError.isToken
        }
    }
    
    private func makeNumber(_ token: String) throws -> Type {
        guard token.isMatching(expression: NSRegularExpression(pattern: Regex.number.description)) else {
            throw JsonError.isNumberMatching
        }
        guard let number = Int(token) else {
            throw JsonError.isConvertNumber
        }
        return Type.number(number)
    }
    
    private func makeString(_ token: String) throws -> Type {
        guard token.isMatching(expression: NSRegularExpression(pattern: Regex.string.description)) else {
            throw JsonError.isStringMatching
        }
        return Type.string(token)
    }
    
    private func makeBoolean(_ token: String) throws -> Type {
        guard token.isMatching(expression: NSRegularExpression(pattern: Regex.boolean.description)) else {
            throw JsonError.isNumberMatching
        }
        guard let boolean = Bool(token) else {
            throw JsonError.isConvertBoolean
        }
        return Type.bool(boolean)
    }
    
    private func closeCapsule(_ closeToken: String) throws {
        guard let openToken = tokenCapsule.pop() else {
            throw JsonError.isOpenToken
        }
        
        let capsule = openToken + closeToken
        
        switch capsule {
            case JSONPARSER_BRACKET:
                return
            case JOSNPARSER_BRACE:
                return
            default:
                throw JsonError.isClose
        }
    }
    
    private func emptyChekcer() throws {
        if !lexQueue.isEmpty() {
            throw JsonError.isClose
        }
        
        if !tokenCapsule.isEmpty() {
            throw JsonError.isClose
        }
    }
}
