//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Daheen Lee on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static private let arrayPattern = "^\\[\\s*(true|false|\"[\\w\\s]*\"|[\\d]+|\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\})\\s*((?:,\\s*(true|false|\"[\\w\\s]*\"|[\\d]+|\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\}))*)\\s*\\]$"
    static private let objectPattern = "^\\{\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+)\\s*((?:,\\s*\"[\\w\\s]+\"\\s*\\:\\s*(true|false|\"[\\w\\s]*\"|[\\d]+))*)\\s*\\}$"
    
    static func check(input: String) throws {
        let isJSONArray = try match(for: arrayPattern, input: input)
        let isJSONObject = try match(for: objectPattern, input: input)
        if isJSONArray || isJSONObject {
            return
        }
        throw GrammarCheckerError.matchNoPattern
    }
    
    static private func match(for pattern: String, input: String) throws -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            throw GrammarCheckerError.invalidRegexPattern
        }
        let range = NSRange(input.startIndex...,  in: input)
        let matches = regex.matches(in: input, options: [], range: range)
        let matchedString = matches.map { match -> String in
            let range = Range(match.range, in: input)!
            return String(input[range])
        }
        return matchedString.count == 1 && matchedString[0] == input
    }
}
