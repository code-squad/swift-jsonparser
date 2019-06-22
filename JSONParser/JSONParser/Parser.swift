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
        return index < tokens.endIndex - 1
    }
    
    //현재인덱스를 받아서 다음인덱스와 다음인덱스의 값을 반환함
    func readToken(index: Int) throws -> (index: Int, token: String) {
        guard hasNext(index: index) else {
            throw ParsingError.error
        }
        let nextIndex = index + 1
        return (index: nextIndex, token: tokens[nextIndex])
    }
    
    
    func parseString(index: Int) throws -> (index: Int, value: String)? {
        let (index, token) = try readToken(index: index)
        
        guard token.first == "\"" && token.last == "\"" else {
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
        var resultArray = [JsonType]()
        //parseArray가 처리할수있는 값인지 확인해준다.
        let (index, token) = try readToken(index: index)

        guard token == "[" else {
            return nil
        }
        while true {
            let (index, value) = try parseValue(index: index)
            resultArray.append(value)
            
            guard let (index, token) = readToken(index: index) else {
                return nil
            }
            guard token == "]" else {
                return (index, resultArray)
            }
        }
        
        
        
        처음index값이 [ 인지 확인하고, 아니면 nil 반환
        ]를 만날때까지 반복한다.
        index + 1 으로 이동해서 parse 진행하고 배열에 append한다
        ,면 index+1하고 계속 반복한다.

        ]나오면, append한 배열을 반환한다.
        
        return (0, [])
    }


}
