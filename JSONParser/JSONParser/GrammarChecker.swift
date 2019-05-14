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
    static func grammarCheck(_ input: String) throws {
        try bracketCheck(input)
        
        for object in getObjectList(input)
        {
            if objectCheck(object) || arrayCheck(object) {
                throw InputError.containsUnsupportedFormats
            }
        }
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
    
    static private func objectCheck (_ input: String) -> Bool {
        let objectRegexGrammar = regexGrammar.object
        if input.matches(objectRegexGrammar.rawValue) {
            return true
        }
        
        return false
    }
    
    static private func arrayCheck (_ input: String) -> Bool {
        let arrayRegexGrammar = regexGrammar.array
        if input.matches(arrayRegexGrammar.rawValue) {
            return true
        }
        
        return false
    }
    
    static private func getObjectList (_ input: String) -> [String] {
        let objectRegexGrammar = regexGrammar.object
        return regex(pattern: objectRegexGrammar.rawValue, string: input)
    }
    
    static private func bracketCheck (_ input: String) throws {
        let curryBracketOpen = DevideCharacter.curlyBracketOpen
        let curryBracketClose = DevideCharacter.curlyBracketClose
        let squareBracketOpen = DevideCharacter.squareBracketOpen
        let squareBracketClose = DevideCharacter.squareBracketClose
        var bracketStack = [DevideCharacter]()
        var eachCheck = ""
        
        for character in input {
            eachCheck += String(character)
            if character == curryBracketOpen.rawValue || character == squareBracketOpen.rawValue {
                bracketStack.append(DevideCharacter(rawValue: character)!)
            }
            if character == curryBracketClose.rawValue || character == squareBracketClose.rawValue {
                try bracketCloseCheck(DevideCharacter(rawValue: character)!, bracketStack)
                bracketStack.removeLast()
                eachCheck = try eachGrammarCheck(eachCheck)
            }
        }
        
        if bracketStack.count != 0 {
            throw InputError.containsUnsupportedFormats
        }
    }
    
    static private func bracketCloseCheck (_ close: DevideCharacter, _ bracketStack: [DevideCharacter]) throws {
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
    
    static private func eachGrammarCheck (_ input: String) throws -> String {
        
        if !(objectCheck(input) || arrayCheck(input)) && input != " ]" {
            throw InputError.containsUnsupportedFormats
        }
        
        return ""
    }
}
