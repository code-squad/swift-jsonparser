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
        case .JSONArray(let tokens):
            jsonData.paranet = (tokens.count, "배열")
            parseToken(tokens)
        default:
            throw JSONParser.Error.invalidToken
        }
        
        return jsonData
    }
    
   mutating private func parseToken(_ tokens:[Token]){
        for token in tokens{
            switch token {
            case .JSONArray(let tokens) :
                jsonData.arrayCount += 1
                return parseToken(tokens)
            case .string:
                jsonData.stringCount += 1
            case .bool:
                jsonData.boolCount += 1
            case .number:
                jsonData.numberCount += 1
            }
        }
    }
}
