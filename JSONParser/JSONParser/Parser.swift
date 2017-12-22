//
//  Parser.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    static func matchValuesToJSONType(_ userInput: String?) -> JSONData {
        let inputValue = userInput ?? ""
        
        if inputValue.hasPrefix("[") && inputValue.hasSuffix("]") {
            return setTargetToArray(inputValue)
        } else if inputValue.hasPrefix("{") && inputValue.hasSuffix("}") {
            return setTargetToObject(inputValue)
        }
        return setTargetToArray("")
    }
    
    static func setTargetToArray (_ input: String) -> JSONData {
        let grammarChecker = GrammarChecker()
        var targetArray = [String]()
        do {
            targetArray = try grammarChecker.checkArray(input)
        } catch {
            print(GrammarChecker.GrammarError.array.message)
        }
        let JSONArray = targetArray.matchType(targetArray)
        return JSONArray
    }
    
    static func setTargetToObject (_ input: String) -> JSONData {
        let grammarChecker = GrammarChecker()
        var targetObject = [String:String]()
        do {
            let split = try grammarChecker.checkObject(input)
            targetObject = newTargetObject(split)
        } catch {
            print(GrammarChecker.GrammarError.object)
        }
        
        let JSONObject = targetObject.matchType(targetObject)
        return JSONObject
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

