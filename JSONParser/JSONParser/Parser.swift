//
//  Parser.swift
//  JSONParser
//
//  Created by JH on 08/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum ParsingError: Error {
    case mustComma
    case noMoreTokens
    case unsupportedType
    case endedWithRemainingTokens
    case mustColon
}

struct Parser {
    
    private var tokens = [String]()
    
    mutating func startParsing(tokens: [String]) throws -> JsonType {
        self.tokens = tokens
        let (finalIndex, result) = try parseValue(index: -1)
        if finalIndex == tokens.endIndex - 1 {
            return result
        }
        throw ParsingError.endedWithRemainingTokens
    }
    
    private func parseValue(index: Int) throws -> (index: Int, value: JsonType) {
        if let (index, string) = try parseString(index: index) {
            return (index, string)
        } else if let (index, number) = try parseNumber(index: index) {
            return (index, number)
        } else if let (index, bool) = try parseBool(index: index) {
            return (index, bool)
        } else if let (index, object) = try parseObject(index: index) {
            return (index, object)
        } else if let (index, array) = try parseArray(index: index) {
            return (index, array)
        }
        throw ParsingError.unsupportedType
    }
    
    ///다음인덱스를 확인함(return에 있는 조건이 실패할경우 false반환함)
    private func hasNext(index: Int) -> Bool {
        return index < tokens.endIndex - 1
    }
    
    ///현재인덱스를 받아서 다음인덱스와 다음인덱스의 값을 반환함
    private func readToken(index: Int) throws -> (index: Int, token: String) {
        guard hasNext(index: index) else {
            throw ParsingError.noMoreTokens
        }
        let nextIndex = index + 1
        return (index: nextIndex, token: tokens[nextIndex])
    }
    
    
    private func parseString(index: Int) throws -> (index: Int, value: String)? {
        let (startIndex, firstToken) = try readToken(index: index)
        
        guard  firstToken == String(Mark.quotationMark) else {
            return nil
        }
        var currentIndex = startIndex
        var stringOutput = ""
        
        while true {
            let (index, token) = try readToken(index: currentIndex)
            currentIndex = index
            
            guard token != String(Mark.quotationMark) else {
                break
            }
            stringOutput.append(token)
        }
        return (currentIndex, stringOutput)
    }
    
    private func parseNumber(index: Int) throws -> (index: Int, value: Double)? {
        let (index, token) = try readToken(index: index)
        
        guard let number = Double(token) else {
            return nil
        }
        return (index, number)
    }
    
    private func parseBool(index: Int) throws -> (index: Int, value: Bool)? {
        let (index, token) = try readToken(index: index)
        
        guard let bool = Bool(token) else {
            return nil
        }
        return (index, bool)
    }
    
    private func parseArray(index: Int) throws -> (index: Int, value: [JsonType])? {
        //parseArray가 처리할수있는 값인지 확인해준다.
        let (startIndex, token) = try readToken(index: index)
        //parseArray가 시작되는 조건
        guard token == String(Mark.startArray) else {
            return nil
        }
        
        // 빈배열 예외처리
        let (finalIndex, final) = try readToken(index: startIndex)
        guard final != String(Mark.endArray) else {
            return (finalIndex, [])
        }
        
        //배열파싱
        var resultArray = [JsonType]()
        var currentIndex = startIndex
        
        while true {
            
            let (index, value) = try parseValue(index: currentIndex)
            resultArray.append(value)
            
            let (nextIndex, token) = try readToken(index: index)
            currentIndex = nextIndex
            
            //token이 ]면 while루프를 벗어나고, 최종인덱스와, 값이저장되어있는 배열을 반환함
            guard token != String(Mark.endArray) else {
                break
            }
            guard token == String(Mark.comma) else {
                throw ParsingError.mustComma
            }
        }
        return (currentIndex, resultArray)
    }
    
    private func parseObject(index: Int) throws -> (index: Int, value: [String: JsonType])? {
        //시작문자가 { 인지 확인함
        let (startIndex, startToken) = try readToken(index: index)
        guard startToken == String(Mark.startObject) else {
            return nil
        }
        //빈오브젝트처리
        let (finalIndex, finalToken) = try readToken(index: startIndex)
        guard finalToken != String(Mark.endObject) else {
            return (finalIndex, [:])
        }
        //오브젝트파싱
        var outputObject = [String: JsonType]()
        var index = startIndex
        while true {
            guard let (stringIndex, string) = try parseString(index: index) else {
                return nil
            }
            let (colonIndex, colon) = try readToken(index: stringIndex)
            guard colon == String(Mark.colon) else {
                throw ParsingError.mustColon
            }
            let (valueIndex, value) = try parseValue(index: colonIndex)
            outputObject[string] = value
            
            let (nextIndex, nextToken) = try readToken(index: valueIndex)
            index = nextIndex
            
            if nextToken == String(Mark.comma) {
                continue
            }
            if nextToken == String(Mark.endObject) {
                break
            }
            return nil // 콤마도아니고 }도 아니면 nil반환
        }
        return (index, outputObject)
    }
    
}
