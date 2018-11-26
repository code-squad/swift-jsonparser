//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 22..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static func checkValidOfGrammar(string:String) -> Bool {
        guard !self.checkColonInArray(string: string) else {return  false}
        guard self.checkBasicGrammar(string: string) else {return false}
        return true
    }
    
    static private func checkColonInArray(string:String) -> Bool {
        let regex = "\\[\\s*\"(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\"\\s*:\\s*(\"(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\"|\\d+|true|false)\\s*\\]"
        return string.range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkBasicGrammar(string:String) -> Bool {
        guard !checkString(string: string) else {return true}
        guard !checkNumber(string: string) else {return true}
        guard !checkBool(string: string) else {return true}
        guard !checkArray(string: string) else {return true}
        guard !checkObject(string: string) else {return true}
        return false
    }
    
    static private func checkString(string:String) -> Bool {
        let regex = "^\"(.+)\"$"
        return string.range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkNumber(string:String) -> Bool {
        let regex = "^\\d+$"
        return string.range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkBool(string:String) -> Bool {
        let regex = "TRUE|FALSE"
        return string.uppercased().range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkArray(string:String) -> Bool {
        let regex = "^\\[.+\\]$"
        return string.range(of: regex, options: .regularExpression) != nil
    }
    
    static private func checkObject(string:String) -> Bool {
        let regex = "^\\{.+\\}$"
        return string.range(of: regex, options: .regularExpression) != nil
    }
}
