//
//  Parser.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum JSONDataType {
    case number(Int)
    case characters(String)
    case boolean(Bool)
//    case object([String:JSONDataType])
}

class Parser {
    enum Error: Swift.Error {
        case unexpectedEndOfInput
        case invalidToken(String)
        
        var errorMessage: String {
            switch self {
            case .unexpectedEndOfInput:
                return "Unexpected end of input"
            case .invalidToken(let token):
                return "Invalid token: \(token)"
            }
        }
    }
    
    private let tokens: [String]
    private var position = 0
    
    init(tokens: [String]) {
        self.tokens = tokens
    }
    
    // 토큰이 남았는지 확인 및 토큰 반환
    private func getNextToken() -> String? {
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
        
        while let token: String = getNextToken() {
            // token 분석 - 이 토큰이 어떤 데이터인지(어떤 Token타입인지)
            let jsonDataType = try makeDataFrom(token)
            switch jsonDataType {
            case .characters(let value):
                jsonAllowedData.characters.append(value)
            case .number(let value):
                jsonAllowedData.numbers.append(value)
            case .boolean(let value):
                jsonAllowedData.booleans.append(value)
            }
        }
        return JSONData(jsonAllowedData.numbers, jsonAllowedData.characters, jsonAllowedData.booleans)
    }
    
    private func makeDataFrom(_ token: String) throws -> JSONDataType {
        // 토큰의 첫글자를 분석하여 데이터화 시도
        guard let firstCharacter = token.first else {
            throw Parser.Error.invalidToken(token)
        }
        
        switch firstCharacter {
        case "0"..."9":
            // 토큰이 숫자로 시작하면 숫자 데이터
            let numberData: Int = try makeNumberData(token)
            return JSONDataType.number(numberData)
        case "\"":
            // 토큰이 따옴표로 시작하면 문자열 데이터
            let charactersData: String = makeCharactersData(token)
            return JSONDataType.characters(charactersData)
        case "f", "t":
            guard let booleanData: Bool = makeBooleanData(token) else {
                throw Parser.Error.invalidToken(token)
            }
            return JSONDataType.boolean(booleanData)
        case "{": // 객체 데이터 시작
            makeObjectData(token)
            return JSONDataType.boolean(true)
        default:
            throw Parser.Error.invalidToken(token)
        }
    }
    
    private func makeNumberData(_ token: String) throws -> Int {
        var value = 0
        for nextCharacter in token {
            switch nextCharacter {
            case "0"..."9":
                let digitValue = Int(String(nextCharacter))!
                value = 10 * value + digitValue
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        return value
    }
    
    private func makeCharactersData(_ token: String) -> String {
        var characters: String = ""
        var saveStartFlag = false
        for nextCharacter in token {
            // 닫는 따옴표를 만나기전까지 문자열로 저장
            switch nextCharacter {
            case "\"":
                if saveStartFlag {
                    return characters
                }
                saveStartFlag = !saveStartFlag
            default:
                characters += String(nextCharacter)
            }
        }
        return characters
    }
    
    private func makeBooleanData(_ token: String) -> Bool? {
        var booleanText: String = ""
        for nextCharacter in token {
            switch nextCharacter {
            case "e":
                booleanText += String(nextCharacter)
                return Bool(booleanText)
            default:
                booleanText += String(nextCharacter)
            }
        }
        return Bool(booleanText)
    }
    
    func makeObjectData(_ token: String) {
        
    }
}
