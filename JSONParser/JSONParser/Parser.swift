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
    
}

struct Parser {
    
    private var tokens: [String]
    
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
        throw ParsingError.unsupportedType
    }
    
    
    //다음인덱스를 확인함(return에 있는 조건이 실패할경우 false반환함)
    func hasNext(index: Int) -> Bool {
        return index < tokens.endIndex - 1
    }
    
    //현재인덱스를 받아서 다음인덱스와 다음인덱스의 값을 반환함
    func readToken(index: Int) throws -> (index: Int, token: String) {
        guard hasNext(index: index) else {
            throw ParsingError.noMoreTokens
        }
        let nextIndex = index + 1
        return (index: nextIndex, token: tokens[nextIndex])
    }
    
    
    func parseString(index: Int) throws -> (index: Int, value: String)? {
        let (index, token) = try readToken(index: index)
        
        guard token.first == Structure.quotationMark && token.last == Structure.quotationMark else {
            return nil
        }
        var stringToken = token
        stringToken.removeFirst()
        stringToken.removeLast()
        
        return (index, stringToken)
    }
    
    func parseNumber(index: Int) throws -> (index: Int, value: Double)? {
        let (index, token) = try readToken(index: index)

        guard let number = Double(token) else {
            return nil
        }
        return (index, number)
    }
    
    func parseBool(index: Int) throws -> (index: Int, value: Bool)? {
        let (index, token) = try readToken(index: index)

        guard let bool = Bool(token) else {
            return nil
        }
        return (index, bool)
    }
    
    func parseArray(index: Int) throws -> (index: Int, value: [JsonType])? {
        //parseArray가 처리할수있는 값인지 확인해준다.
        let (startIndex, token) = try readToken(index: index)
        //배열이 시작되는 조건
        guard token == String(Structure.startArray) else {
            return nil
        }
        
        //배열파싱
        var resultArray = [JsonType]()
        var currentIndex = startIndex

        while true {
            
            let (index, value) = try parseValue(index: currentIndex)
            resultArray.append(value)
            
            let (nextIndex, token) = try readToken(index: index)
            currentIndex = nextIndex
            
            guard token != String(Structure.endArray) else {
                break
            }
            guard token == String(Structure.comma) else {
                throw ParsingError.mustComma
            }
        }
        return (currentIndex, resultArray)
    }


}
