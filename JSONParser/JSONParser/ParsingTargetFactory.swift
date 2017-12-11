//
//  ObjectProducer.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ParsingTargetFactory {
    
    func setTargetType (_ input: String?) -> [String] {
        let inputValue = input ?? ""
        var stringValues : [String] = []
        
        if inputValue.hasPrefix("[") && inputValue.hasSuffix("]") {
            let trimmedValue = inputValue.trimmingCharacters(in: ["[","]"])
            if trimmedValue.contains("{") && trimmedValue.contains("}") {
                // object가 배열 안에 있는 경우
            } else {
                stringValues = makeTargetArray(trimmedValue)
            }
        }
        
        if inputValue.hasPrefix("{") && inputValue.hasSuffix("}") {
            let trimmedValue = inputValue.trimmingCharacters(in: ["{","}"])
            stringValues = makeTargetObject(trimmedValue)
        }
        
        return stringValues
    }
}

extension ParsingTargetFactory {
    
    private func makeTargetArray (_ changeTarget: String) -> [String] {
        var stringValuesToArray : [String] = []
        
        let valuesList = changeTarget.split(separator: ",")
        stringValuesToArray = valuesList.map({(value:String.SubSequence)->String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
        return stringValuesToArray
    }
    
    private func makeTargetObject (_ changeTarget: String) -> [String] {
        var stringValuesToObject : [String] = []
        
        let listOfValue = changeTarget.split(separator: ",").map({(value: String.SubSequence) -> String in String(value)}) // [""key":value", ""key":value"]
        for tempValue in listOfValue {
            stringValuesToObject.append(makeTempDictionary(tempValue).value)
        }
        return stringValuesToObject
    }
    
    private func makeTempDictionary (_ value: String) -> (key: String, value: String){
        let splitedTempDictionary = value.split(separator: ":").map({(value: String.SubSequence) -> String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
        let key = splitedTempDictionary[0]
        let value = splitedTempDictionary[1]
        
        return (key, value)
    }
    

}

