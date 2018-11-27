//
//  GrammarChecker.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 22..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct GrammarChecker {
    static private let string = "(\"[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣0-9\\s']+?\")"
    static private let number = "(\\d+)"
    static private let bool = "(true|false)"
    static private let stringNumberBool = "\(string)|\(number)|\(bool)"
    static private let subArray = "(\\[([,\\s]*|\(stringNumberBool))+\\])"
    static private let subObject = "(\\{(([\\s]*?|\(string))+:([\\s,]*?|\(stringNumberBool))+)+\\})"
    static private let array = "(\\[([,\\s]*|\(stringNumberBool)|\(subArray)|\(subObject))+\\])"
    static private let object = "(\\{(([\\s]*?|\(string))+:([\\s,]*?|\(stringNumberBool)|\(subArray)|\(subObject))+)+\\})"
    
    static func checkInputData(data:String) -> Bool {
        let willCheckData = data
        guard !checkGrammar(regex: "^\(array)$", string: willCheckData) else {return true}
        guard !checkGrammar(regex: "^\(object)$", string: willCheckData) else {return true}
        
        return false
    }
    
    static func checkValidOfGrammar(string:String) -> Bool {
        guard self.checkBasicGrammar(data: string) else {return false}
        return true
    }
    
    static private func checkBasicGrammar(data:String) -> Bool {
        let willCheckData = data
        guard !checkGrammar(regex: "^\(string)$", string: willCheckData) else {return true}
        guard !checkGrammar(regex: "^\(number)$", string: willCheckData) else {return true}
        guard !checkGrammar(regex: "^\(bool)$", string: willCheckData) else {return true}
        guard !checkGrammar(regex: "^\(array)$", string: willCheckData) else {return true}
        guard !checkGrammar(regex: "^\(object)$", string: willCheckData) else {return true}

        return false
    }
    
    static private func checkGrammar(regex:String, string:String) -> Bool {
        return string.range(of: regex, options: .regularExpression) != nil
    }
}
