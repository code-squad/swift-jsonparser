//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 22..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static private let s = "\\s*"
    static private let d = "\\d"
    static private let w = "\\w"
    static private let bool = "(true|false)"
    static private let string = "\"\(s)(\(w)|\(s)|\(d)|\\{|\\}|\\[|\\])+\(s)\""
    
    static func check(input:String) -> Bool {
        guard !self.checkColonInArray(input: input) else {return  false}
        if input.hasPrefix("{") && input.hasSuffix("}") {
            guard checkObject(input: input) else {return false}
        }
        return true
    }
    
    static private func checkColonInArray(input:String) -> Bool {
        let regex = "\\[\\s*\"(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\"\\s*:\\s*(\"(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\"|\\d+|true|false)\\s*\\]"
        return input.range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkObject(input:String) -> Bool {
        let removedSquare = input.trimmingCharacters(in: ["{","}"])
        guard !checkInArray(input: removedSquare) else {return false}
        guard !checkInObject(input: removedSquare) else {return false}
        return true
    }
    
    static private func checkInObject(input:String) -> Bool {
        let regex = "\\{\(s)(\(s)(\(s)\(string)\(s):\(s)(\(string)|\(d)+|\(bool))\(s))\(s),?)+\(s)\\}"
        return input.range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkInArray(input:String) -> Bool {
        let regex = "\\[\(s)(\(s)((\(s)\"\(s)(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\(s)\"|\\d+|true|false))\(s),?\(s))+\(s)\\]"
        return input.range(of: regex, options: .regularExpression) != nil
    }
}
