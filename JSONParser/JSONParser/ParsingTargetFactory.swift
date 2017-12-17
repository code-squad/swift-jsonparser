//
//  ParsingTargetFactory.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ParsingTargetFactory {
    
    static func setTargetToArray (_ input: String) -> [String] {
        let trimmedValue = input.trimmingCharacters(in: ["[","]"])
        if trimmedValue.contains("{") && trimmedValue.contains("}") {
            return makeTargetArrayWithObject(trimmedValue)
        } else {
            return makeTargetArray(trimmedValue)
        }
    }
    
    static func setTargetToObject (_ input: String) -> Dictionary<String,String> {
        let trimmedValue = input.trimmingCharacters(in: ["{","}"])
        return makeTargetObject(trimmedValue)
    }
    
}

extension ParsingTargetFactory {
    
    static func makeTargetArray (_ changeTarget: String) -> [String] {
        var stringValuesToArray : [String] = []
        
        let valuesList = changeTarget.split(separator: ",")
        stringValuesToArray = valuesList.map({(value:String.SubSequence)->String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
        
        return stringValuesToArray
    }
    
    // 배열안에 딕셔너리가 있는 경우 {}괄호와 글자를 따로 저장하고 빼내는 작업
    static func makeTargetArrayWithObject(_ value: String) -> [String] {
        var rawValue = value
        var openBracketBound = String.Index(encodedOffset: 0)
        var closeBracketBound = String.Index(encodedOffset: 0)
        var splitedValues : [String] = []
        
        while rawValue.contains("{"){
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
        let singleValues = makeTargetArray(rawValue)
        
        return splitedValues + singleValues
    }
    
}

extension ParsingTargetFactory {
    
    static func makeTargetObject (_ changeTarget: String) -> Dictionary<String,String> {
        var stringDictionaryToObject : Dictionary<String, String> = [:]
        
        let listOfValue = changeTarget.split(separator: ",").map({(value: String.SubSequence) -> String in String(value)}) // [""key":value", ""key":value"]
        for tempValue in listOfValue {
            stringDictionaryToObject[makeTempDictionary(tempValue).key] = makeTempDictionary(tempValue).value
        }
        return stringDictionaryToObject
    }
    
    static func makeTempDictionary (_ value: String) -> (key: String, value: String){
        let splitedTempDictionary = value.split(separator: ":").map({(value: String.SubSequence) -> String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
        let key = splitedTempDictionary[0]
        let value = splitedTempDictionary[1]
        
        return (key, value)
    }

}

