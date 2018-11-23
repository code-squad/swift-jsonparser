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
    
    static func checkValidOfGrammar(string:String) -> Bool {
        guard !self.checkColonInArray(string: string) else {return  false}
        if string.hasPrefix("{") && string.hasSuffix("}") {
            guard checkObject(string: string) else {return false}
        }
        return true
    }
    
    static private func checkColonInArray(string:String) -> Bool {
        let regex = "\\[\\s*\"(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\"\\s*:\\s*(\"(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\"|\\d+|true|false)\\s*\\]"
        return string.range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkObject(string:String) -> Bool {
        let removedSquare = string.trimmingCharacters(in: ["{","}"])
        guard !checkInArray(string: removedSquare) else {return false}
        guard !checkInObject(string: removedSquare) else {return false}
        return true
    }
    
    static private func checkInObject(string:String) -> Bool {
        let regex = "\\{\(s)(\(s)(\(s)\(string)\(s):\(s)(\(string)|\(d)+|\(bool))\(s))\(s),?)+\(s)\\}"
        return string.range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkInArray(string:String) -> Bool {
        let regex = "\\[\(s)(\(s)((\(s)\"\(s)(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\(s)\"|\\d+|true|false))\(s),?\(s))+\(s)\\]"
        return string.range(of: regex, options: .regularExpression) != nil
    }
}
