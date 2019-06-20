//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Daheen Lee on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static private let arrayPattern = "^\\[\\s*(true|false|\"[^\"]*\"|[\\d]+|\\[\\s*(true|false|\"[^\"]*\"|[\\d]+)\\s*((?:,\\s*(true|false|\"[^\"]*\"|[\\d]+))*)\\s*\\]|\\{\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+)\\s*((?:,\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+))*)\\s*\\})\\s*((?:,\\s*(true|false|\"[^\"]*\"|[\\d]+|\\[\\s*(true|false|\"[^\"]*\"|[\\d]+)\\s*((?:,\\s*(true|false|\"[^\"]*\"|[\\d]+))*)\\s*\\]|\\{\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+)\\s*((?:,\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+))*)\\s*\\}))*)\\s*\\]$"
    static private let objectPattern = "^\\{\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+|\\{\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+)\\s*((?:,\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+))*)\\s*\\}|\\[\\s*(true|false|\"[^\"]*\"|[\\d]+)\\s*((?:,\\s*(true|false|\"[^\"]*\"|[\\d]+))*)\\s*\\])\\s*((?:,\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+|\\{\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+)\\s*((?:,\\s*\"[^\"]+\"\\s*\\:\\s*(true|false|\"[^\"]*\"|[\\d]+))*)\\s*\\}|\\[\\s*(true|false|\"[^\"]*\"|[\\d]+)\\s*((?:,\\s*(true|false|\"[^\"]*\"|[\\d]+))*)\\s*\\]))*)\\s*\\}$"
    
    static func check(input: String) -> Bool {
        let isJSONArray = match(for: arrayPattern, input: input)
        let isJSONObject = match(for: objectPattern, input: input)
        return isJSONArray || isJSONObject
    }
    
    static private func match(for pattern: String, input: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return false
        }
        let range = NSRange(input.startIndex...,  in: input)
        let matches = regex.matches(in: input, options: [], range: range)
        return matches.count == 1
    }
}
