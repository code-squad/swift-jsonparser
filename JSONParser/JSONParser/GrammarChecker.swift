//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 24..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    
    enum Error: Swift.Error {
        case invalidToken(String)
        case invalidPattern(String)
        
        var errorMessage: String {
            switch self {
            case .invalidToken(let token):
                return "지원하지 않는 형식을 포함하고 있습니다. : \(token)"
            case .invalidPattern(let pattern):
                return "정규표현식의 패턴이 잘못되었습니다. : \(pattern)"
            }
        }
    }
    
    static let keyPattern: String  = "^\\\"[^\\\"]+\\\"$"
    static let booleanPattern: String = "(false|true)"
    static let numberPattern: String = "\\d+"
    static let charactersPattern: String = "(^\\\"([^\\\"|^\\[])+\\\"$)"
    
    static func checkPattern(token: String, pattern: String) throws -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            throw GrammarChecker.Error.invalidPattern(pattern)
        }
        
        guard let matchedRange = regex.firstMatch(in: token, options: [], range: NSMakeRange(0, token.count))?.range else {
            return false
        }
        
        return token == token[matchedRange]
    }
    
}

extension String {
    public subscript(range: NSRange) -> String {
        let start = self.index(self.startIndex, offsetBy: range.location)
        let end = self.index(start, offsetBy: range.length)
        
        return String(self[start..<end])
    }
}
