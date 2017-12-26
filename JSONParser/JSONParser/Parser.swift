//
//  Parser.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    static func matchValues(_ parseTarget: ([String], String)) throws -> JSONData {
        let convertTarget = parseTarget.0
        let inputValue = parseTarget.1
        
        if inputValue.hasPrefix("[") && inputValue.hasSuffix("]") {
            do {
                let JSONArray = try convertTarget.matchType(convertTarget)
                return JSONArray
            } catch let error {
                throw error
            }
        } else if inputValue.hasPrefix("{") && inputValue.hasSuffix("}") {
            let targetObject = newTargetObject(convertTarget)
            do {
                let JSONObject = try targetObject.matchType(targetObject)
                return JSONObject
            } catch let error {
                throw error
            }
        }
       return try [""].matchType([""])
    }
   
    
    // MARK: Private functions to make object
    
    static func newTargetObject(_ pairsOfValue: [String]) -> [String:String] {
        var stringDictionaryToObject = [String:String]()
        for tempValue in pairsOfValue {
            stringDictionaryToObject[makeTempDictionary(tempValue).key] = makeTempDictionary(tempValue).value
        }
        return stringDictionaryToObject
    }
    
    static func makeTempDictionary (_ value: String) -> (key: String, value: String) {
        let splitedTempDictionary = value.split(separator: ":")
            .map(){value in String(value)
                .trimmingCharacters(in: .whitespacesAndNewlines)}
        let key = splitedTempDictionary[0]
        let value = splitedTempDictionary[1]
        
        return (key, value)
    }

}

