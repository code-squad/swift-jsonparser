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
        return true
    }
    
    static private func checkColonInArray(string:String) -> Bool {
        let regex = "\\[\\s*\"(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\"\\s*:\\s*(\"(\\w|\\s|\\d|\\{|\\}|\\[|\\])+\"|\\d+|true|false)\\s*\\]"
        return string.range(of: regex, options: .regularExpression) != nil
    }
}

