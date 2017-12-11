//
//  ObjectProducer.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct ParsingTargetFactory {
    
    func makeParsingTarget (_ input: String?) -> [String] {
        var stringValues : [String] = []
        let inputValue = input ?? ""
        
        if inputValue.hasPrefix("[") && inputValue.hasSuffix("]") {
            let trimmedValue = inputValue.trimmingCharacters(in: ["[","]"])
            let valuesList = trimmedValue.split(separator: ",")
            stringValues = valuesList.map({(value:String.SubSequence)->String in String(value).trimmingCharacters(in: .whitespacesAndNewlines)})
            return stringValues
        }
        return stringValues
    }
    
    
}

