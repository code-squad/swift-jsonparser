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
        
//        if input.matches("\\{[A-z\"0-9.: ]+\\}") {
//            throw InputError.containsUnsupportedFormats
//        }
        
        for object in getObjectList(input)
        {
            if objectExist(object) || arrayExist(object) {
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
    
    static private func objectExist (_ input: String) -> Bool {
        if input.matches("\\{[A-z\"0-9:. ]+\\}") {
            return true
        }
        
        return false
    }
    
    static private func arrayExist (_ input: String) -> Bool {
        if input.matches("\\[[A-z\"0-9. ]+\\]") {
            return true
        }
        
        return false
    }
    
    static private func getObjectList (_ input: String) -> [String] {
        return regex(pattern: "\\{[A-z\"0-9:. ]+\\}", string: input)
    }
    
    static private func bracketCheck (_ input: String) throws {
        let curryBracketOpen = DevideCharacter.curlyBracketOpen
        let curryBracketClose = DevideCharacter.curlyBracketClose
        let squareBracketOpen = DevideCharacter.squareBracketOpen
        let squareBracketClose = DevideCharacter.squareBracketClose
        var bracketStack = [DevideCharacter]()
        
        for character in input {
            if character == curryBracketOpen.rawValue || character == squareBracketOpen.rawValue {
                let bracketOpen = DevideCharacter(rawValue: character) ?? curryBracketOpen
                bracketStack.append(bracketOpen)
            }
            if character == curryBracketClose.rawValue {
                try bracketCloseCheck(close: curryBracketClose, bracketStack)
                bracketStack.removeLast()
            }
            if character == squareBracketClose.rawValue {
                try bracketCloseCheck(close: squareBracketClose, bracketStack)
                bracketStack.removeLast()
            }
        }
        
        if bracketStack.count != 0 {
            throw InputError.containsUnsupportedFormats
        }
    }
    
    static private func bracketCloseCheck (close: DevideCharacter, _ bracketStack: [DevideCharacter]) throws {
        switch close {
        case .curlyBracketClose:
            if bracketStack.last != .curlyBracketClose {
            throw InputError.containsUnsupportedFormats
        }
        case .squareBracketClose:
        if bracketStack.last != .squareBracketClose {
            throw InputError.containsUnsupportedFormats
        }
        default: break
        }
    }
}
