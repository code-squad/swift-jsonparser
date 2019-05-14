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
        try checkBracketCount(input)
    }
    
    static private func regex(pattern:String, string:String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {return []}
        
        let range = NSRange(string.startIndex..., in: string)
        let matches = regex.matches(in: string, options: [], range: range)
        
        return matches.map {
            let range = Range($0.range, in: string)!
            return String(string[range])
        }
    }
    
    static private func checkObjectExist (_ input: String) -> Bool {
        let objectRegexGrammar = regexGrammar.object
        
        return input.matches(objectRegexGrammar.rawValue)
    }
    
    static private func checkArrayExist (_ input: String) -> Bool {
        let arrayRegexGrammar = regexGrammar.array
        
        return input.matches(arrayRegexGrammar.rawValue)
    }
    
    static private func getObjectList (_ input: String) -> [String] {
        let objectRegexGrammar = regexGrammar.object
        return regex(pattern: objectRegexGrammar.rawValue, string: input)
    }
    
    static private func checkBracketCount (_ input: String) throws {
        let curlyBracketOpen = DevideCharacter.curlyBracketOpen
        let curlyBracketClose = DevideCharacter.curlyBracketClose
        let squareBracketOpen = DevideCharacter.squareBracketOpen
        let squareBracketClose = DevideCharacter.squareBracketClose
        var bracketStack = [DevideCharacter]()
        var eachCheck = ""
        var bracket:DevideCharacter
        
        for character in input {
            eachCheck += String(character)
            bracket = DevideCharacter(rawValue: character) ?? DevideCharacter.colon
            if bracket == curlyBracketOpen || bracket == squareBracketOpen {
                bracketStack.append(DevideCharacter(rawValue: character)!)
            }
            if bracket == curlyBracketClose || bracket == squareBracketClose {
                try checkBracketClose(DevideCharacter(rawValue: character)!, bracketStack)
                bracketStack.removeLast()
                eachCheck = try checkEachGrammar(eachCheck)
            }
        }
        
        if bracketStack.count != 0 {
            throw InputError.containsUnsupportedFormats
        }
    }
    
    static private func checkBracketClose (_ close: DevideCharacter, _ bracketStack: [DevideCharacter]) throws {
        switch close {
        case .curlyBracketClose:
            if bracketStack.last != .curlyBracketOpen {
            throw InputError.containsUnsupportedFormats
        }
        case .squareBracketClose:
        if bracketStack.last != .squareBracketOpen {
            throw InputError.containsUnsupportedFormats
        }
        default: break
        }
    }
    
    static private func checkEachGrammar (_ input: String) throws -> String {
        if !(checkObjectExist(input) || checkArrayExist(input)) && input != " ]" {
            throw InputError.containsUnsupportedFormats
        }
        
        return ""
    }
}
