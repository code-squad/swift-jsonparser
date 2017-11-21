//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
// \{.[^\[\]]*\} 객체 내에 배열 금지 regex

struct GrammarChecker {
    let arrayPatten = "(?<=\\[).*(?=\\])"
    let objectPatten = "(?<=\\{).*(?=\\})"
    
    func listMatches(patten: String, inString string: String) throws -> [String] {
        guard let regex = try? NSRegularExpression(pattern: patten, options: []) else {
            throw JSONParser.ErrorCode.invalidJSONStandard
        }
        let range = NSMakeRange(0, string.count)
        guard let matches = regex.firstMatch(in: string, options: [], range: range) else {
            throw JSONParser.ErrorCode.invalidJSONStandard
        }
        let arrMatches = [matches]
        return arrMatches.map {
            let range = $0.range
            return (string as NSString).substring(with: range)
        }
    }
    
    
    
    
}
