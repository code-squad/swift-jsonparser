//
//  Parser.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    enum ParseTarget {
        case list
        case object
        
        var description: String {
            switch self {
            case .list:
                return "배열"
            case .object:
                return "객체"
            }
        }
    }
    
    static func matchValues(_ target: (parseValue: [String], parseType: ParseTarget)) throws -> JSONData {
        let convertTarget = target.parseValue
        let targetType = target.parseType
        
        if targetType == Parser.ParseTarget.list {
            do {
                let JSONArray = try convertTarget.matchType(convertTarget)
                return JSONArray
            } catch let error {
                throw error
            }
        } else if targetType == Parser.ParseTarget.object {
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

