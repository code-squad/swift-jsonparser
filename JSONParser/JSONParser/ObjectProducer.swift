//
//  ObjectProducer.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ObjectProducer {
    
    func makeObject (_ input: String?) -> Dictionary<String, String> {
        var stringValuesList : Dictionary<String, String> = [:]
        guard let inputValue = input else {return [:]}
        
        if inputValue.hasPrefix("{") && inputValue.hasSuffix("}") {
            let trimmedInput = inputValue.trimmingCharacters(in: ["{","}"])
            let listOfValue = trimmedInput.split(separator: ",").map({(value: String.SubSequence) -> String in String(value)}) // [""key":value", ""key":value"]
            for tempValue in listOfValue {
                stringValuesList[makeDictionary(tempValue).key] = makeDictionary(tempValue).value
             }
        }
        return stringValuesList
    }
    
    private func makeDictionary (_ value: String) -> (key: String, value: String){
        let split = value.split(separator: ":").map({(value: String.SubSequence) -> String in String(value)})
        let key = split[0]
        let value = split[1]
        
        return (key, value)
    }
    
}



