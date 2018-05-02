//
//  Parser.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum JSONDataValue {
    case number(Int)
    case characters(String)
    case boolean(Bool)
    case object([String:JSONDataValue])
    case array([JSONDataValue])
}

protocol TokenConvertible {
    func hasAvailableNextToken(position: Int) -> Bool
    func getToken(index: Int) -> String
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
                return "지원하지 않는 형식을 포함하고 있습니다. : \(token)"
            }
        }
    }
    
    private let tokenData: TokenConvertible
    private var position = 0
    private let openBracket: String = "["
    private let closeBracket: String = "]"
    private let openCurlyBracket: String = "{"
    private let closeCurlyBracket: String = "}"
    private let colon: String = ":"

    init(tokenData: TokenConvertible) {
        self.tokenData = tokenData
    }
    
    private func getNextToken() throws -> String? {
        guard tokenData.hasAvailableNextToken(position: self.position) else {
            return nil
        }
        let token = self.tokenData.getToken(index: position)
        position += 1
        return token
    }

    func parse() throws -> JSONData {
        while let token: String = try getNextToken() {
            switch token {
            case openCurlyBracket:
                let objectData: JSONDataValue = try makeObjectJSONData()
                return ObjectJSONData(jsonData: objectData)
            case openBracket:
                let arrayData: JSONDataValue = try makeArrayJSONData()
                return ArrayJSONData(jsonData: arrayData)
            default:
                throw Parser.Error.invalidToken(token)
            }
        }
        throw Parser.Error.unexpectedEndOfInput
    }
    
    func makeArrayJSONData() throws -> JSONDataValue {
        var arrayJSONData: [JSONDataValue] = [JSONDataValue]()
        while let token: String = try getNextToken() {
            switch token {
            case closeBracket:
                return JSONDataValue.array(arrayJSONData)
            default:
                arrayJSONData.append(try makeValue(token))
            }
        }
        return JSONDataValue.array(arrayJSONData)
    }
    
    private func makeObjectJSONData() throws -> JSONDataValue {
        var objectJSONData: [String:JSONDataValue] = [String:JSONDataValue]()
        var key: String = ""
        while let token: String = try getNextToken() {
            switch token {
            case closeCurlyBracket:
                return JSONDataValue.object(objectJSONData)
            case colon:
                // value만들기
                guard let valueToken = try getNextToken() else {
                    throw Parser.Error.unexpectedEndOfInput
                }
                objectJSONData[key] = try makeValue(valueToken)
            default:
                // key만들기
                key = try makeObjectKey(token)
            }
        }
        
        return JSONDataValue.object(objectJSONData)
    }
    
    private func makeObjectKey(_ token: String) throws -> String {
        guard try GrammarChecker.checkPattern(token: token, pattern: GrammarChecker.keyPattern) else {
            throw GrammarChecker.Error.invalidToken(token)
        }
        return token
    }
    
    private func makeValue(_ valueToken: String) throws -> JSONDataValue {
        // 중첩객체
        if valueToken == openCurlyBracket {
            return try makeObjectJSONData()
        }
        // 중첩배열
        if valueToken == openBracket {
            return try makeArrayJSONData()
        }
        // 숫자
        if try GrammarChecker.checkPattern(token: valueToken, pattern: GrammarChecker.numberPattern) {
            let numberData = try makeNumberData(valueToken)
            return JSONDataValue.number(numberData)
        }
        // 부울
        if try GrammarChecker.checkPattern(token: valueToken, pattern: GrammarChecker.booleanPattern) {
            guard let booleanData = makeBooleanData(valueToken) else {
                throw Parser.Error.invalidToken(valueToken)
            }
            return JSONDataValue.boolean(booleanData)
        }
        // 문자열
        if try GrammarChecker.checkPattern(token: valueToken, pattern: GrammarChecker.charactersPattern) {
            let charactersData = makeCharactersData(valueToken)
            return JSONDataValue.characters(charactersData)
        }
        throw Parser.Error.invalidToken(valueToken)
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

}
