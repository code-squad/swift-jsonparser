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
            } else {
                return makeTargetArray(trimmedValue)
            }
        }
        
        if inputValue.hasPrefix("{") && inputValue.hasSuffix("}") {
            let trimmedValue = inputValue.trimmingCharacters(in: ["{","}"])
            return makeTargetObject(trimmedValue)
        }
        
        return makeTargetArray("")
    }
}

extension ParsingTargetFactory {
    
    private func makeTargetArray (_ changeTarget: String) -> ParsingTarget {
        var stringValuesToArray : [String] = []
        
        let valuesList = changeTarget.split(separator: ",")
        stringValuesToArray = valuesList.map({(value:String.SubSequence)->String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
        
        return MyArray(stringValuesToArray)
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
    

}

