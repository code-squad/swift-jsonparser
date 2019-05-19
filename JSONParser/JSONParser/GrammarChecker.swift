//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by joon-ho kil on 5/8/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static func checkJsonGrammar(_ input: String) throws {
        var verifyJsonGrammerPass = false
        let devideCharacter = DevideCharacter(rawValue: input.first ?? ":") ?? .colon
        
        if devideCharacter == DevideCharacter.squareBracketOpen {
            verifyJsonGrammerPass = checkArrayGrammar(input)
        }
        if devideCharacter == DevideCharacter.curlyBracketOpen {
           verifyJsonGrammerPass = checkObjectGrammar(input)
        }
        
        if verifyJsonGrammerPass == false {
            throw InputError.containsUnsupportedFormats
        }
    }
    
    static private func checkObjectGrammar (_ input: String) -> Bool {
        let objectRegexGrammar = RegexGrammar.object
        
        return input.matches(objectRegexGrammar.rawValue)
    }
    
    static private func checkArrayGrammar (_ input: String) -> Bool {
        let arrayRegexGrammar = RegexGrammar.array
        
        return input.matches(arrayRegexGrammar.rawValue)
    }
}
