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
    
    func check(format: String) -> Bool {
        let maxDepth = format.filter{
            return ["[","{"].contains($0)
            }.count
        return checkList(format: format,depth: maxDepth) || checkObject(format: format, depth: maxDepth)
    }
    
    private func checkObject(format: String, depth: Int) -> Bool {
        let regex = JsonPattern.object.getRegex(depth)
        return check(string: format, pattern: regex)
    }
    
    private func checkList(format: String, depth: Int) -> Bool {
        let regex = JsonPattern.list.getRegex(depth)
        return check(string: format, pattern: regex)
    }
    
    public func check(string: String, pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        if let match = regex.firstMatch(in: string, options: [], range: string.range) {
            let result = NSString.init(string:string).substring(with: (match.range))
            print(result)
            return result.range == string.range
        }
        return false
    }
    
}
