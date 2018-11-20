//
//  JsonAnalysis.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 16..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct Converter {
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
    
    static func convertToArray(string:String) -> ArrayUsableType? {
        if isStringForm(string:string) {
            return JsonString.init(string: string.removeDoubleQuotationMarks())
        }
        if isNumberForm(string:string) {
            return JsonNumber.init(number: Double(string) ?? 0)
        }
        if isBoolForm(string:string) {
            return JsonBool.init(bool: string.isTrue())
        }
        if isObject(string:string) {
            return createObject(string)
        }
        
        return nil
    }
    
    static private func createObject(_ data:String) -> JsonObject? {
        let creator = CollectionCreator.init(ObjectCreator())
        return creator.create(data) as? JsonObject
    }
    
    static func convertToObject(string:String) -> ObjectUsableType? {
        if isStringForm(string:string) {
            return JsonString.init(string: string.removeDoubleQuotationMarks())
        }
        if isNumberForm(string:string) {
            return JsonNumber.init(number: Double(string) ?? 0)
        }
        if isBoolForm(string:string) {
            return JsonBool.init(bool: string.isTrue())
        }

        return nil
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
