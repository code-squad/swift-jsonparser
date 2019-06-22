//
//  Parser.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum ParsingError: Error {
    case error
}

struct Parser {
    
    var tokens: [String]
    
    func parseValue(index: Int) throws -> (index: Int, value: JsonType) {
        if let (index, string) = try parseString(index: index) {
            return (index, string)
        } else if let (index, number) = try parseNumber(index: index) {
            return (index, number)
        } else if let (index, bool) = try parseBool(index: index) {
            return (index, bool)
        } else if let (index, array) = try parseArray(index: index) {
            return (index, array)
        }
        return (0,"")
    }
    
    
    //다음인덱스를 확인함(return에 있는 조건이 실패할경우 false반환함)
    func hasNext(index: Int) -> Bool {
        return index < tokens.endIndex
    }
    
    //현재인덱스를 받아서 다음인덱스와 다음인덱스의 값을 반환함
    func readToken(index: Int) -> (index: Int, token: String)? {
        guard hasNext(index: index) else {
            return nil
        }
        let nextIndex = index + 1
        return (index: nextIndex, token: tokens[nextIndex])
    }
    
    
    func parseString(index: Int) throws -> (index: Int, value: String)? {
        guard let (index, token) = readToken(index: index) else {
            throw ParsingError.error
        }
        guard token.first == "\"" && token.last == "\"" else {
            return nil
        }
        var stringToken = token
        stringToken.removeFirst()
        stringToken.removeLast()
        
        return (index, stringToken)
    }
    
    func parseNumber(index: Int) throws -> (index: Int, value: Double)? {
        guard let (index, token) = readToken(index: index) else {
            throw ParsingError.error
        }
        guard let number = Double(token) else {
            return nil
        }
        return (index, number)
    }
    
    func parseBool(index: Int) throws -> (index: Int, value: Bool)? {
        guard let (index, token) = readToken(index: index) else {
            throw ParsingError.error
        }
        guard let bool = Bool(token) else {
            return nil
        }
        return (index, bool)
    }
    
    func parseArray(index: Int) throws -> (index: Int, value: [JsonType])? {
        return (0, [])
    }


}
