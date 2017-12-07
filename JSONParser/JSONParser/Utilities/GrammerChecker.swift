//
//  GrammerChecker.swift
//  JSONParser
//
//  Created by yuaming on 2017. 12. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct GrammerChecker {
    static func matchPatternForType(in value: String) -> Bool {
        if value.matchPatterns(pattern: JSONDataTypePattern.leftBrace) ||
            value.matchPatterns(pattern: JSONDataTypePattern.leftBrace) ||
            value.matchPatterns(pattern: JSONDataTypePattern.bool) ||
            value.matchPatterns(pattern: JSONDataTypePattern.number) ||
            value.matchPatterns(pattern: JSONDataTypePattern.rightBrace)
            {
           return true
        } 
        
        return false
    }
}
