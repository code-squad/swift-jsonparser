//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// JSONData -> JSONObject

struct JSONAnalyzer {
    
    static func makeData(with jsonString: String) throws -> JSONObject {
        guard jsonString.isArray() else {
            throw InputError.invalidInput
        }
        let stringWithoutSquareBracket = jsonString.stripAwayOutLayer()
        
        let splitStrings = stringWithoutSquareBracket.split(separator: ",").map{$0.trimmingCharacters(in: .whitespaces)}
        
        var intArray = [Int]()
        var boolArray = [Bool]()
        var stringArray = [String]()
        
        for contents in splitStrings {
            if contents.isString() {
                let stringWithoutDoubleQuotationMark = contents.stripAwayOutLayer()
                stringArray.append(stringWithoutDoubleQuotationMark)
            }
            else if let convertStringToBool = Bool(contents) {
                boolArray.append(convertStringToBool)
            }
            else if let convertStringToInteger = Int(contents) {
                intArray.append(convertStringToInteger)
            }
            else { throw InputError.invalidInput }
            
        }
        return JSONObject(stringArray: stringArray, intArray: intArray, boolArray: boolArray)
    }
}

extension String {
    func isArray() -> Bool {
        guard self[self.startIndex] == "["
            && self[self.index(before: self.endIndex)] == "]" else { return false }
        return true
    }
    func stripAwayOutLayer() -> String {
        return String(self[self.index(after: self.startIndex)..<self.index(before: self.endIndex)])
    }
    func isString() -> Bool {
        guard self[self.startIndex] == "\""
            && self[self.index(before: self.endIndex)] == "\"" else { return false }
        return true
    }
}
