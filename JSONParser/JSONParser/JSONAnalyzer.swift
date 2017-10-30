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
    
    static func makeObject(with jsonString: String) throws -> JSONObject {
        guard jsonString.isArray() else {
            throw FormatError.notFormatted
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
            else { throw FormatError.invalidDataType }
            
        }
        return JSONObject(stringArray: stringArray, intArray: intArray, boolArray: boolArray)
    }
}

extension JSONAnalyzer {
    enum FormatError: String, Error {
        case notFormatted = "데이터 형식이 올바르지 않습니다."
        case invalidDataType = "지원하지 않는 데이터 타입 입니다."
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
