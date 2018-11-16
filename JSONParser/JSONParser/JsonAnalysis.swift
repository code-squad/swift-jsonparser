//
//  JsonAnalysis.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 16..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonAnalysis {
    static private func isBoolForm(string:String) -> Bool {
        return string.uppercased() == "TRUE" || string.uppercased() == "FALSE"
    }
    
    static private func isStringForm(string:String) -> Bool {
        return string.hasPrefix("\"") && string.hasSuffix("\"")
    }
    
    static private func isNumberForm(string:String) -> Bool {
        return string.range(of: "^\\d+$", options: .regularExpression) != nil
    }
    
    static private func isObject(string:String) -> Bool {
        return string.hasPrefix("{") && string.hasSuffix("}")
    }
    
    static func isWhatForm(string:String) -> String {
        if isBoolForm(string:string) {
            return "bool"
        }
        if isStringForm(string:string) {
            return "string"
        }
        if isNumberForm(string:string) {
            return "number"
        }
        if isObject(string:string) {
            return "object"
        }
        return "none"
    }
    
    static func isWhatCollectionType(string:String) -> Creator? {
        switch (string.first,string.last) {
        case ("[","]"):
            return ArrayCreator()
        case ("{","}"):
            return ObjectCreator()
        default:
            return nil
        }
    }
}
