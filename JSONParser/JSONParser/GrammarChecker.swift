//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    static func checkFirstObjectJSON(of inString: String) -> Bool {
        if inString.hasPrefix("[") && inString.hasSuffix("]") {
            return true
        }
        if inString.hasPrefix("{") && inString.hasSuffix("}") {
            return true
        }
        return false
    }
    
    static func checkElements(of values: [String]) -> Bool {
        let invalidCharacter: Set<String> = [":", "{", "}", "[", "]"]
        for element in values {
            if invalidCharacter.contains(element) {
                return false
            }
        }
        return true
    }
    
}
