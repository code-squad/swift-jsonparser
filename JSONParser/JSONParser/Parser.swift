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
    case object([[[String:JSONDataType]]])
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
    
    private let token: Token

    init(token: Token) {
        self.token = token
    }

    func parse() throws -> JSONData {
        typealias JSONAllowedData = (numbers: [Int], characters: [String], booleans: [Bool], objects: [[[String:JSONDataType]]])
        var jsonAllowedData: JSONAllowedData = ([], [], [], [])
        
        // bool, number, string 데이터
        for token in token.valueToken {
            let jsonData = try makeDataFrom(token)
            
            switch jsonData {
            case .characters(let value):
                jsonAllowedData.characters.append(value)
            case .number(let value):
                jsonAllowedData.numbers.append(value)
            case .boolean(let value):
                jsonAllowedData.booleans.append(value)
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        
        // object 데이터
        for token in token.objectToken {
            let jsonObjectData = try makeObjectData(token)
            jsonAllowedData.objects.append(jsonObjectData)
        }
        
        return JSONData(jsonAllowedData.numbers, jsonAllowedData.characters, jsonAllowedData.booleans, jsonAllowedData.objects)
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
            case "}":
                continue
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
            case "}":
                continue
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
            case "}":
                continue
            default:
                booleanText += String(nextCharacter)
            }
        }
        return Bool(booleanText)
    }
    
    func makeObjectData(_ objectToken: [String]) throws -> [[String:JSONDataType]] {
        
        var objectData: [[String:JSONDataType]] = []
        
        for token in objectToken {
            let keyValue: [String] = token.split(separator: ":").map { String($0) }
            let keyToken = keyValue[0]
            let valueToken = keyValue[1]
            
            let key: String = makeObjectKeyFrom(keyToken)
            let value: JSONDataType = try makeObjectValueFrom(valueToken)
            objectData.append([key:value])
        }
        
        return objectData
    }
    
    func makeObjectKeyFrom(_ keyToken: String) -> String {
        var key: String = ""
        for nextCharacter in keyToken {
            switch nextCharacter {
            case "{", "\"":
                continue
            default:
                key.append(nextCharacter)
            }
        }
        return key
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
        default:
            throw Parser.Error.invalidToken(valueToken)
        }
    }
}
