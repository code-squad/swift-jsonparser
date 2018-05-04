//
//  JSONPaser.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

class Parser {
    
    private var tokens: Queue<String>
    private var tokenCapsule: Stack<String>

    init(_ tokens: Queue<String>) {
        self.tokens = tokens
        self.tokenCapsule = Stack<String>()
    }
    
    func parse() throws -> JSON {
    
        switch tokens.front() {
            case TokenSplitUnit.startBracket.string:
                guard let array = JSONArray(try arrayMaker()) else {
                    throw JSONPaserErorr.isJsonPaser
                }
                return array
            case TokenSplitUnit.startBrace.string:
                guard let object = JSONObjectArray(try objectArrayMaker()) else {
                    throw JSONPaserErorr.isJsonPaser
                }
                return object
        default:
            throw JSONPaserErorr.noStartToken
        }
    }
    
    private func arrayMaker() throws -> JSONType {
        var jsonArray: [JSONType] = []
        
        while let token = tokens.dequeue() {
            switch token {
                case TokenSplitUnit.startBracket.string:
                    tokenCapsule.push(token)
                    jsonArray.append(try arrayMaker())
                case TokenSplitUnit.startBrace.string:
                    tokenCapsule.push(token)
                    jsonArray.append(try JSONType.Object(objectMaker()))
                case TokenSplitUnit.colon.string, TokenSplitUnit.comma.string:
                    try nextTokenChecker(front())
                case TokenSplitUnit.endBrackert.string, TokenSplitUnit.endBrace.string:
                    try noMatchingThrow(tokenCapsule.pop(), token)
            default:
                jsonArray.append(try setJSONData(token))
            }
        }

        if !isClose() {
            throw JSONPaserErorr.isCapsule
        }
        return JSONType.Array(jsonArray)
    }
    
    private func dequeue() throws -> String {
        guard let token = tokens.dequeue() else {
            throw JSONPaserErorr.isNil
        }
        return token
    }
    
    private func front() throws -> String {
        guard let front = tokens.front() else {
            throw JSONPaserErorr.isNil
        }
        return front
    }
    
    private func objectArrayMaker() throws -> JSONType {
        var jsonOjbectArray: [[String: JSONType]] = []

        while let token = tokens.front() {
            switch token {
            case TokenSplitUnit.startBrace.string:
                try tokenCapsule.push(dequeue())
            case TokenSplitUnit.comma.string:
                if isClose() { break }
                continue
            case TokenSplitUnit.endBrace.string:
                try noMatchingThrow(tokenCapsule.pop(), dequeue())
            default:
                jsonOjbectArray.append(try objectMaker())
            }
        }
        if !isClose() {
            throw JSONPaserErorr.isCapsule
        }
        return JSONType.ObjectArray(jsonOjbectArray)
    }
    
    private func objectMaker() throws -> [String: JSONType] {
        var jsonObject: [String: JSONType] = [:]
        let object = try dequeue().split(separator: ":").map{ String($0) }
        
        let key = object[0]
        let value = object[1]
        jsonObject[key] = try setJSONData(value)
        return jsonObject
    }
    
    private func setJSONData(_ token: String) throws -> JSONType {
        
        guard let first = token.first else {
            throw JSONPaserErorr.isNil
        }
        
        switch first {
            case "0"..."9"          : return try numberChecker(token)
            case "\""               : return try stringChecker(token)
            case "f", "t", "F", "T" : return try booleanChecker(token)
        default: throw JSONPaserErorr.notFirst
        }
    }
    
    private func noMatchingThrow(_ front: String?, _ end: String) throws {
        guard let font = front else {
            throw JSONPaserErorr.isNil
        }

        let capsule = font + end
        
        switch capsule {
            case Capsule.Bracket.rawValue: break
            case Capsule.Brace.rawValue: break
        default:
            throw JSONPaserErorr.isJsonPaser
        }
    }
    
    private func numberChecker(_ numberToken: String) throws -> JSONType {
        try numberToken.pattenMatching(RegexPatten.NumberPatten.rawValue)
        
        guard let number = Int(numberToken) else {
            throw JSONPaserErorr.isNumber
        }
        return JSONType.Number(number)
    }
    
    private func booleanChecker(_ booleanToken: String) throws -> JSONType {
        try booleanToken.pattenMatching(RegexPatten.BooleanPaten.rawValue)
        guard let boolean = Bool(booleanToken) else {
            throw JSONPaserErorr.isBoolean
        }
        return JSONType.Boolean(boolean)
    }
    
    private func stringChecker(_ stringToken: String) throws -> JSONType {
        try stringToken.pattenMatching(RegexPatten.StringPatten.rawValue)
        return JSONType.String(stringToken)
    }

    private func isClose() -> Bool {
        if (tokens.isEmpty() == tokenCapsule.isEmpty()) && tokenCapsule.isEmpty() {
            return true
        }
        return false
    }
    
    private func nextTokenChecker(_ front: String) throws {
        switch front {
            case TokenSplitUnit.endBrackert.string: throw JSONPaserErorr.isNextToken
            case "": throw JSONPaserErorr.isNextToken
            case TokenSplitUnit.comma.string: throw JSONPaserErorr.isNextToken
            case TokenSplitUnit.colon.string: throw JSONPaserErorr.isNextToken
        default:
            break
        }
    }
}
