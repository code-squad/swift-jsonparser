//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    static func checkFirstObjectJSON(of inString: String) throws {
        if inString.hasPrefix("[") && inString.hasSuffix("]") {
            return
        }
        if inString.hasPrefix("{") && inString.hasSuffix("}") {
            return
        }
        throw ErrorCode.invalidJSONStandard
        
    }
    
    static func checkElements(of values: [String]) throws {
        let invalidCharacter: Set<String> = [":", "{", "}", "[", "]"]
        for element in values {
            if invalidCharacter.contains(element) {
                throw ErrorCode.invalidJSONStandard
            }
        }
    }
    
}
