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
  
        if input.first == DevideCharacter.squareBracketOpen.rawValue {
            verifyJsonGrammerPass = checkArrayGrammar(input)
        }
        if input.first == DevideCharacter.curlyBracketOpen.rawValue {
           verifyJsonGrammerPass = checkObjectGrammar(input)
        }
        
        if verifyJsonGrammerPass == false {
            throw InputError.containsUnsupportedFormats
        }
    }
    
    static private func checkObjectGrammar (_ input: String) -> Bool {
        let objectRegexGrammar = RegexGrammar.object
        
        return input.matches(objectRegexGrammar.rawValue) && input.matches(for: objectRegexGrammar.rawValue).first == input
    }
    
    static private func checkArrayGrammar (_ input: String) -> Bool {
        let arrayRegexGrammar = RegexGrammar.array
        
        return input.matches(arrayRegexGrammar.rawValue)
    }
}
