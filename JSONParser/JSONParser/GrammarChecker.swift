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
    
    func flatJSON(of inString: String) throws -> JSONType {
        if inString.hasPrefix("[") && inString.hasSuffix("]") {
            return JSONType.arrayType(inString.removeBrace())
        }
        if inString.hasPrefix("{") && inString.hasSuffix("}") {
            return JSONType.objectType(inString.removeBrace())
        }
        throw ErrorCode.invalidJSONStandard
    }
    
    func checkElements(of values: [String]) throws -> [String] {
        for element in values {
            if invalidCharacter.contains(element) {
                throw ErrorCode.invalidJSONStandard
            }
        }
        return values
    }
    
}
