//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 이진영 on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    private static let objectRegex = "^\\{ ?((|, ?)(\"[a-zA-Z0-9]+\" ?: ?)(\"[a-zA-Z0-9 ]+\"|[0-9]+|true|false))+ ?\\}$"
    private static let arrayRegex = "^\\[ ?((|, ?)(\"[a-zA-Z0-9 ]+\"|[0-9]+|true|false|(\\{ ?((|, ?)(\"[a-zA-Z0-9]+\" ?: ?)(\"[a-zA-Z0-9 ]+\"|[0-9]+|true|false))+ ?\\})))+ ?\\]$"
    
    static func checkGrammar(input: String) throws {
        if !matches(input) {
            throw GrammarCheckError.noMatchesPattern
        }
    }
    
    private static func matches(_ value: String) -> Bool {
        let isArray = value.range(of: arrayRegex, options: .regularExpression) != nil
        let isObject = value.range(of: objectRegex, options: .regularExpression) != nil
        
        return isArray || isObject
    }
}
