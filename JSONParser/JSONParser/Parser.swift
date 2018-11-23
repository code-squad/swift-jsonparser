//
//  JsonAnalysis.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 16..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct Parser {
    static private func isStringForm(string:String) -> Bool {
        return string.hasPrefix("\"") && string.hasSuffix("\"")
    }
    
    static private func isNumberForm(string:String) -> Bool {
        return string.range(of: "^[\\d\\.]+$", options: .regularExpression) != nil
    }
    
    static private func isBoolForm(string:String) -> Bool {
        return string.uppercased() == "TRUE" || string.uppercased() == "FALSE"
    }
    
    static private func isObject(string:String) -> Bool {
        return string.hasPrefix("{") && string.hasSuffix("}")
    }
    
    static private func isArray(string:String) -> Bool {
        return string.hasPrefix("[") && string.hasSuffix("]")
    }
    
    static func convert(string:String) -> JsonType? {
        guard GrammarChecker.checkValidOfGrammar(string: string) else {return nil}
        if self.isStringForm(string:string) {
            return JsonString.init(string: string)
        }
        if self.isNumberForm(string:string) {
            return JsonNumber.init(number: string)
        }
        if self.isBoolForm(string:string) {
            return JsonBool.init(bool: string)
        }
        if self.isObject(string:string) {
            return JsonObject.init(object: string)
        }
        if self.isArray(string: string) {
            return JsonArray.init(array: string)
        }
        return nil
    }
}
