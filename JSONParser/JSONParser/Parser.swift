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
            return JsonObject.init(object: makeObject(string: string))
        }
        if self.isArray(string: string) {
            return JsonArray.init(array: makeArray(string: string))
        }
        return nil
    }
    
    static private func makeArray(string:String) -> [JsonType] {
        let removedSquare = string.trimmingCharacters(in: ["[","]"])
        let extractedData = RegularExpression.extractData(string: removedSquare)
        var jsonArray = [JsonType]()
        
        for data in extractedData {
            guard let parsedData = Parser.convert(string: data) else {continue}
            jsonArray.append(parsedData)
        }
        
        return jsonArray
    }
    
    static private func makeObject(string:String) -> [String:JsonType] {
        let removedSquare = string.trimmingCharacters(in: ["{","}"])
        let extractedData = RegularExpression.extractData(string: removedSquare)
        var jsonObject = [String:JsonType]()
        
        for index in stride(from: extractedData.startIndex, through: extractedData.endIndex - 1, by: 2) {
            guard let keyData = Parser.convert(string:extractedData[index]) as? KeyOfObject else {continue}
            guard let valueData = Parser.convert(string:extractedData[index + 1]) else {continue}
            jsonObject[keyData.key()] = valueData
        }
        
        return jsonObject
    }
}
