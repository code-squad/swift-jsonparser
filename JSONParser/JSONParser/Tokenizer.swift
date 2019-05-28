//
//  Tokenizer.swift
//  JSONParser
//
//  Created by 이진영 on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum TokenElement: Character {
    case startOfArray = "["
    case endOfArray = "]"
    case comma = ","
    case whitespaces = " "
    case string = "\""
    
    var pair: Character {
        switch self {
        case .string:
            return TokenElement.string.rawValue
        default:
            return TokenElement.whitespaces.rawValue
        }
    }
    
    init?(first: Character?) {
        switch first {
        case "\"":
            self = .string
        default:
            self = .whitespaces
        }
    }
}

struct Tokenizer {
    static func tokenize(input: String) throws -> [String] {
        guard input.first == TokenElement.startOfArray.rawValue, input.last == TokenElement.endOfArray.rawValue else {
            throw TypeError.unsupportedType
        }
        
        let arrayBracket = CharacterSet(charactersIn: "\(TokenElement.startOfArray.rawValue)\(TokenElement.endOfArray.rawValue)")
        
        let trimmingResult = input.trimmingCharacters(in: arrayBracket)
        let splitResult = trimmingResult.split(separator: TokenElement.comma.rawValue)
        let rawTokens = splitResult.map { String($0).trimmingCharacters(in: .whitespaces) }
        
        let tokens = verify(rawTokens: rawTokens)
        
        return tokens
    }
    
    private static func verify(rawTokens: [String]) -> [String] {
        var tokens: [String] = []
        var token = ""
        var firstOfToken: TokenElement?
        
        for rawToken in rawTokens {
            if firstOfToken == nil {
                firstOfToken = TokenElement(first: rawToken.first)
            }
            
            if firstOfToken == TokenElement.whitespaces {
                tokens.append(rawToken)
                firstOfToken = nil
            } else if rawToken.last == firstOfToken?.pair {
                token = token + rawToken
                tokens.append(token)
                
                firstOfToken = nil
                token.removeAll()
            } else {
                token = token + rawToken + ", "
            }
        }
        
        return tokens
    }
    
}
