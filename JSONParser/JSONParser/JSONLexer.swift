//
//  JSONLexer.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 25..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONLexer {
    func listMatches(pattern: String, inString value: String) throws -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            throw ErrorCode.invalidPatten
        }
        let results = regex.matches(in: value, options: [], range: NSRange(value.startIndex..., in: value))
        return results.map{ String(value[Range($0.range, in: value)!]) }
    }
        
}
