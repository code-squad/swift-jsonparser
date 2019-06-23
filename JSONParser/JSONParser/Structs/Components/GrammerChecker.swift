//
//  GrammerChecker.swift
//  JSONParser
//
//  Created by 이동영 on 17/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct GrammerChecker: Checker {
    typealias T = String
    
    static func check(format: String) -> Bool {
        let maxDepth = format.filter{
            return ["[","{"].contains($0)
            }.count
        return self.checkObject(format: format, depth: maxDepth) || self.checkList(format: format, depth: maxDepth)
    }
    
    private static func checkObject(format: String, depth: Int = 0) -> Bool {
        let regex = Pattern.getObject(depth: depth)
        return check(string: format, pattern: regex)
    }
    
    private static func checkList(format: String, depth: Int = 0) -> Bool {
        let regex = Pattern.getList(depth: depth)
        return check(string: format, pattern: regex)
    }
    
    private static func check(string: String, pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let matchRange = regex.rangeOfFirstMatch(in: string, options: [], range: string.range)
        return matchRange == string.range
    }
    
}
