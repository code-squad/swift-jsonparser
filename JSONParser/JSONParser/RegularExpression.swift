//
//  RegularExpression.swift
//  JSONParser
//
//  Created by JINA on 03/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct RegularExpression {
    private static func matches(for regex: String, in text: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        return results.map { String(text[Range($0.range, in: text)!]) }
    }
    
    static func bringData(from input: [String], regex: String) -> [String] {
        var data = [String]()
        for val in input {
            let matchData = matches(for: regex, in: String(val))
            for idx in 0 ..< matchData.count {
                data.append(matchData[idx])
            }
        }
        return data
    }
}

