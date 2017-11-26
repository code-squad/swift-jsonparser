//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    private let invalidCharacter: Set<String> = [":", "{", "}", "[", "]"]
    
    func flatJSON(Of inString: String) throws -> JSONType {
        if inString.hasPrefix("[") && inString.hasSuffix("]") {
            return JSONType.arrayType(removeBrace(inString))
        }
        if inString.hasPrefix("{") && inString.hasSuffix("}") {
            return JSONType.objectType(removeBrace(inString))
        }
        throw ErrorCode.invalidJSONStandard
    }
    
    func checkElements(Of values: [String]) throws -> [String] {
        for element in values {
            if invalidCharacter.contains(element) { throw ErrorCode.invalidJSONStandard }
        }
        return values
    }
    
    func removeBrace(_ value: String) -> String {
        var rawJSON = value
        rawJSON.removeFirst()
        rawJSON.removeLast()
        return rawJSON
    }
    
}
