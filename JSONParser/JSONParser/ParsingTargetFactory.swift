//
//  ParsingTargetFactory.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ParsingTargetFactory {
    
    func convertTargetToString (_ input: String?) -> ParsingTarget {
        let inputValue = input ?? ""
        
        if inputValue.hasPrefix("[") && inputValue.hasSuffix("]") {
            let trimmedValue = inputValue.trimmingCharacters(in: ["[","]"])
            if trimmedValue.contains("{") && trimmedValue.contains("}") {
                // object가 배열 안에 있는 경우
                while trimmedValue.contains("{") {
                    return makeTargetArrayWithObject(trimmedValue)
                }
            } else {
                return MyArray(makeTargetArray(trimmedValue))
            }
        }
        
        if inputValue.hasPrefix("{") && inputValue.hasSuffix("}") {
            let trimmedValue = inputValue.trimmingCharacters(in: ["{","}"])
            return makeTargetObject(trimmedValue)
        }
        
        return MyArray(makeTargetArray(""))
    }
    
    
}

extension ParsingTargetFactory {
    
    private func makeTargetArray (_ changeTarget: String) -> [String] {
        var stringValuesToArray : [String] = []
        
        let valuesList = changeTarget.split(separator: ",")
        stringValuesToArray = valuesList.map({(value:String.SubSequence)->String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
        
        return stringValuesToArray
    }
    
    private func makeTargetObject (_ changeTarget: String) -> ParsingTarget {
        var stringDictionaryToObject : Dictionary<String, String> = [:]
        
        let listOfValue = changeTarget.split(separator: ",").map({(value: String.SubSequence) -> String in String(value)}) // [""key":value", ""key":value"]
        for tempValue in listOfValue {
            stringDictionaryToObject[makeTempDictionary(tempValue).key] = makeTempDictionary(tempValue).value
        }
        return MyObject(stringDictionaryToObject)
    }
    
    private func makeTempDictionary (_ value: String) -> (key: String, value: String){
        let splitedTempDictionary = value.split(separator: ":").map({(value: String.SubSequence) -> String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
        let key = splitedTempDictionary[0]
        let value = splitedTempDictionary[1]
        
        return (key, value)
    }
    
    // 배열안에 딕셔너리가 있는 경우 {}괄호와 글자를 따로 저장하고 빼내는 작업
    private func makeTargetArrayWithObject(_ value: String) -> ParsingTarget {
        var rawValue = value
        var tempIndex = 0
        var openBracketBound = String.Index(encodedOffset: 0)
        var closeBracketBound = String.Index(encodedOffset: 0)
        var rawValues : [String] = []
        
        while rawValue.contains("{"){
            for char in rawValue.characters {
                if char == "{" {
                    print(tempIndex)
                    openBracketBound = String.Index(encodedOffset: tempIndex)
                }
                if char == "}" {
                    print(tempIndex)
                    closeBracketBound = String.Index(encodedOffset: tempIndex)
                }
                tempIndex += 1
            }
            rawValues.append(String(rawValue[openBracketBound...closeBracketBound]))
            rawValue.removeSubrange(openBracketBound...closeBracketBound)
        }
        let pureValues = makeTargetArray(rawValue)
        
        return MyArray(rawValues + pureValues)
    }
    
    
}

