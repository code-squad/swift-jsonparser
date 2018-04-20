//
//  JSONPaser.swift
//  JSONParser
//
//  Created by Jung seoung Yeo on 2018. 4. 19..
//  Copyright © 2018년 JK. All rights reserved.
//

// 규격이 일치하는지
class Paser {
    typealias JSONDataSaveFormat = (numbers: Array<Int>, strings: Array<String>, booleans: Array<Bool>)
    var jsonDataModel = JSONDataSaveFormat([],[],[])
    private var tokens: Queue<String>
    private var tokenCapsule: Stack<String>
    
    init(_ tokens: Queue<String>) {
        self.tokens = tokens
        self.tokenCapsule = Stack<String>()
    }
    
    func parse() throws -> JSONData {
        while let token = tokens.dequeue() {
            switch token {
                case String(TokenSplitUnit.startBracket.rawValue): tokenCapsule.push(token)
                case String(TokenSplitUnit.endBrackert.rawValue): try isMatching(tokenCapsule.pop(), token)
                case String(TokenSplitUnit.comma.rawValue): try isClose(tokens.font())
            default: try setJSONData(token)
            }
        }
        
        return JSONData(jsonDataModel.strings,jsonDataModel.numbers,jsonDataModel.booleans)
    }
    
    private func setJSONData(_ token: String) throws {
        guard let first = token.first else {
            throw JSONPaserErorr.isEmpty
        }
        
        switch first {
            case "0"..."9": try setNumber(token)
            case "\""     : try setString(token)
            case "f", "t" : try setBoolean(token)
        default: throw JSONPaserErorr.isJsonPaser
        }
    }
    
    private func isMatching(_ front: String?, _ end: String) throws {
        guard let font = front else {
            throw JSONPaserErorr.isJsonPaser
        }
        
        let capsule = font + end
        
        switch capsule {
            case Capsule.Bracket.rawValue: break
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
        jsonDataModel.numbers.append(Int(numberToken)!)
    }
    
    private func setString(_ stringToken: String) throws {
        try stringToken.pattenMatching(RegexPatten.StringPatten.rawValue)
        jsonDataModel.strings.append(stringToken)
    }
    
    private func setBoolean(_ booleanToken: String) throws {
        try booleanToken.pattenMatching(RegexPatten.BooleanPaten.rawValue)
        jsonDataModel.booleans.append(Bool(booleanToken)!)
    }
}
