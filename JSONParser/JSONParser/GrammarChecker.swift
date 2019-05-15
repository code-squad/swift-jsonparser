//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by joon-ho kil on 5/8/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String {
    
    /// 문자열의 정규식 일치 여부를 확인합니다.
    ///
    /// - Parameter pattern: 정규식 패턴 문자열
    /// - Returns: true 혹은 false
    func matches(_ pattern: String) -> Bool {
        return self.range(of: pattern, options: .regularExpression) != nil
    }
}

struct GrammarChecker {
    static func checkJsonGrammar(_ input: String) throws {
        var verifyJsonGrammerPass = false
        if input.first == "[" {
            verifyJsonGrammerPass = checkArrayGrammar(input)
        }
        if input.first == "{" {
           verifyJsonGrammerPass = checkObjectGrammar(input)
        }
        
        if verifyJsonGrammerPass == false {
            throw InputError.containsUnsupportedFormats
        }
    }
    
    static private func checkObjectGrammar (_ input: String) -> Bool {
        let objectRegexGrammar = regexGrammar.object
        
        return input.matches(objectRegexGrammar.rawValue)
    }
    
    static private func checkArrayGrammar (_ input: String) -> Bool {
        let arrayRegexGrammar = regexGrammar.array
        
        return input.matches(arrayRegexGrammar.rawValue)
    }
}
