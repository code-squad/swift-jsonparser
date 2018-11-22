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
    static private let object = "\\{\(s)(\(s)(\(s)\(string)\(s):\(s)(\(string)|\(d)+|\(bool))\(s))\(s),?)+\(s)\\}"
    static private let array = "\\[\(s)(\(s)((\(s)\"\(s)(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\(s)\"|\\d+|true|false))\(s),?\(s))+\(s)\\]"
    static private let allData = "(\(object)|\(array)|\(string)|\(d)+|\(bool))"
    
    static private func regex(pattern:String, string:String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {return []}
        
        let range = NSRange(string.startIndex..., in: string)
        let matches = regex.matches(in: string, options: [], range: range)
        
        return matches.map {
            let range = Range($0.range, in: string)!
            return String(string[range])
        }
    }
    
    static func extractData(string:String) -> [String] {
        return self.regex(pattern: allData, string: string)
    }
}
