//
//  JSONParser.swift
//  JSONUnitTest
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.
//


import Foundation

struct JSONParser {
    enum Error:Swift.Error{
        case invalidToken
    }
    
    private var jsonData = JSONData()
    private var token:Token
    init(_ token:Token) {
        self.token = token
    }
    
    mutating func parse() throws -> JSONData{
        
        switch token {
        case .jsonArray(let tokens):
            jsonData.paranet = (tokens.count, "배열")
            parseToken(tokens)
        case .jsonObject(let object):
            jsonData.paranet = (object.count, "객체")
            parseToken(getTokens(object))
        default:
            throw JSONParser.Error.invalidToken
        }
        
        return jsonData
    }
    
   mutating private func parseToken(_ tokens:[Token]){
        for token in tokens{
            switch token {
            case .jsonArray(let tokens) :
                jsonData.arrayCount += 1
                return parseToken(tokens)
            case .jsonObject :
                jsonData.objectCount += 1
            case .string:
                jsonData.stringCount += 1
            case .bool:
                jsonData.boolCount += 1
            case .number:
                jsonData.numberCount += 1
            }
        }
    }
    
    private func getTokens(_ jsonObject:[JSONObject]) -> [Token]{
        var tokens = [Token]()
        for token in jsonObject{
            tokens.append(token.value)
        }
        return tokens
    }
}
