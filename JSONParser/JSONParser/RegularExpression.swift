//
//  RegularExpression.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 15..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct RegularExpression {
    static private let s = "\\s*"
    static private let d = "\\d"
    static private let w = "\\w"
    static private let bool = "(true|false)"
    static private let string = "\"\(s)(\(w)|\(s)|\(d)|\\{|\\}|\\[|\\])+\(s)\""
    
    static private func regex(pattern:String, string:String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {return []}
        
        let range = NSRange(string.startIndex..., in: string)
        let matches = regex.matches(in: string, options: [], range: range)
        
        return matches.map {
            let range = Range($0.range, in: string)!
            return String(string[range])
        }
    }
    
    
    
}
