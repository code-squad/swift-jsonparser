//
//  Parser.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Parser {
    
    func matchValuesToJSONType(_ userInput: String?) -> JSONData {
        let inputValue = userInput ?? ""
        
        if inputValue.hasPrefix("[") && inputValue.hasSuffix("]") {
            return setTargetToArray(inputValue)
        } else if inputValue.hasPrefix("{") && inputValue.hasSuffix("}") {
            return setTargetToObject(inputValue)
        }
        return setTargetToArray("")
    }
    
    func setTargetToArray (_ input: String) -> JSONData {
        let trimmedValue = input.trimmingCharacters(in: ["[","]"])
        let stringArray = makeTargetArray(trimmedValue)
        let JSONArray = stringArray.matchType(stringArray)
        return JSONArray
    }
    
    func setTargetToObject (_ input: String) -> JSONData {
        let trimmedValue = input.trimmingCharacters(in: ["{","}"])
        let stringObj = makeTargetObject(trimmedValue)
        let JSONObj = stringObj.matchType(stringObj)
        return JSONObj
    }
    
    
    // MARK: Make [String]
    
    private func makeTargetArray(_ value: String) -> ConvertTarget {
        var rawValue = value
        var openBracketBound = String.Index(encodedOffset: 0)
        var closeBracketBound = String.Index(encodedOffset: 0)
        var splitedValues : [String] = []
        
        while rawValue.contains("{") {
            var tempIndex = 0
            for char in rawValue.characters {
                if char == "{" {
                    openBracketBound = String.Index(encodedOffset: tempIndex)
                } else if char == "}" {
                    closeBracketBound = String.Index(encodedOffset: tempIndex)
                }
                tempIndex += 1
            }
            splitedValues.append(String(rawValue[openBracketBound...closeBracketBound]))
            rawValue.removeSubrange(openBracketBound...closeBracketBound)
        }
        
        let singleValues = rawValue.split(separator: ",")
                        .map({(value:String.SubSequence)->String in String(value)
                        .trimmingCharacters(in: .whitespacesAndNewlines)})
        
        return splitedValues + singleValues
    }
    
    
    // MARK: Make Object
    
    private func makeTargetObject (_ changeTarget: String) -> ConvertTarget {
        var stringDictionaryToObject : Dictionary<String, String> = [:]
        
        let listOfValue = changeTarget.split(separator: ",").map(){value in String(value)} // [""key":value", ""key":value"]
        for tempValue in listOfValue {
            stringDictionaryToObject[makeTempDictionary(tempValue).key] = makeTempDictionary(tempValue).value
        }
        return stringDictionaryToObject
    }
    
    private func makeTempDictionary (_ value: String) -> (key: String, value: String) {
        let splitedTempDictionary = value.split(separator: ":")
            .map(){value in String(value)
                .trimmingCharacters(in: .whitespacesAndNewlines)}
        let key = splitedTempDictionary[0]
        let value = splitedTempDictionary[1]
        
        return (key, value)
    }
    
}

