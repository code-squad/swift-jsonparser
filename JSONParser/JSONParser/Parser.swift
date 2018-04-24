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
    case object([String:JSONDataType])
    case array([JSONDataType])
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
    
    private let tokenData: Token
    private var position = 0

    init(tokenData: Token) {
        self.tokenData = tokenData
    }
    
    private func getNextToken() throws -> String? {
        guard position < self.tokenData.numberOfToken() else {
            return nil
        }
        let token = self.tokenData.getToken(index: position)
        position += 1
        return token
    }

    func parse() throws -> JSONData {
        while let token: String = try getNextToken() {
            switch token {
            case "[":
                let arrayData: JSONDataType = try makeArrayJSONData()
                return ArrayJSONData(jsonData: arrayData)
            case "{":
                let objectData: JSONDataType = try makeObjectJSONData()
                return ObjectJSONData(jsonData: objectData)
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        
        throw Parser.Error.unexpectedEndOfInput
    }
    
    func makeArrayJSONData() throws -> JSONDataType {
        var arrayJSONData: [JSONDataType] = [JSONDataType]()
        
        while let token: String = try getNextToken() {
            switch token {
            case "[": // 배열 안에 중첩 배열
                arrayJSONData.append(try makeArrayJSONData())
            case "]":
                return JSONDataType.array(arrayJSONData)
            case "{": // 배열 안에 객체
                arrayJSONData.append(try makeObjectJSONData())
            default:
                arrayJSONData.append(try makeNormalData(token))
            }
        }
        
        return JSONDataType.array(arrayJSONData)
    }
    
    func makeObjectJSONData() throws -> JSONDataType {
        var objectJSONData: [String:JSONDataType] = [String:JSONDataType]()
        
        while let token: String = try getNextToken() {
            if token == "}" {
                break
            }
            let objectToken: [String] = token.split(separator: ":").map{ String($0) }
            let valueToken = objectToken[1]
            let key = objectToken[0]
            let value: JSONDataType = try makeObjectValueFrom(valueToken)
            objectJSONData[key] = value
        }
        
        return JSONDataType.object(objectJSONData)
    }
    
    func makeNormalData(_ token: String) throws -> JSONDataType {

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
    
    func makeObjectValueFrom(_ valueToken: String) throws  -> JSONDataType {
        guard let firstCharacter = valueToken.first else {
            throw Parser.Error.invalidToken(valueToken)
        }
        // 들어온 데이터의 첫글자를 보고 어떤 데이터 타입인지 판단
        switch firstCharacter {
        case "0"..."9":
            let numberData = try makeNumberData(valueToken)
            return JSONDataType.number(numberData)
        case "\"":
            let charactersData = makeCharactersData(valueToken)
            return JSONDataType.characters(charactersData)
        case "f", "t":
            guard let booleanData = makeBooleanData(valueToken) else {
                throw Parser.Error.invalidToken(valueToken)
            }
            return JSONDataType.boolean(booleanData)
        case "[":
            return try makeArrayJSONData()
        default:
            throw Parser.Error.invalidToken(valueToken)
        }
    }
}
