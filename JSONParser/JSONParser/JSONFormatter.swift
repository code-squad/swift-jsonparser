//
//  JSONFormatter.swift
//  JSONParser
//
//  Created by Daheen Lee on 21/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONFormatter {
    static let newline = "\n"
    static let tab = "\t"
    static let seperator = ", "
    private var indentationLevel: Int
    
    var indentation: String {
        return String(repeating: JSONFormatter.tab, count: indentationLevel)
    }
    
    init() {
        self.indentationLevel = 0
    }
    
    mutating func process(jsonValue: JSONValue) -> String {
        switch jsonValue {
        case let bool as Bool:
            return getBoolString(for: bool)
        case let num as Int:
            return getNumberString(for: num)
        case let string as String:
            return string
        case let array as [JSONValue]:
            return generateArrayFormat(for: array)
        case let object as [String:JSONValue]:
            return generateObjectFormat(for: object)
        default:
            return ""
        }
    }
    
    private mutating func generateArrayFormat(for jsonArray: [JSONValue]) -> String {
        var arrayString = ""
        var prefix = "\(JSONSymbols.openBracket)"
        for element in jsonArray {
            arrayString += "\(prefix)\(process(jsonValue: element))"
            prefix = JSONFormatter.seperator
        }
        arrayString += "\(JSONSymbols.closedBracket)"
        return arrayString
    }
    
    private mutating func generateObjectFormat(for jsonObject: [String: JSONValue]) -> String {
        var objectString = ""
        var prefix = "\(JSONSymbols.openBrace)\(JSONFormatter.newline)"
        let seperator = "\(JSONFormatter.seperator)\(JSONFormatter.newline)"
        indentationLevel += 1
        for (key, value) in jsonObject {
            objectString += "\(prefix)\(indentation)\(key) : \(process(jsonValue: value))"
            prefix = seperator
        }
        objectString += "\(JSONFormatter.newline)\(JSONSymbols.closedBrace)"
        indentationLevel -= 1
        return objectString
    }
    
    private func getBoolString(for bool: Bool) -> String {
        return bool ? JSONSymbols.trueString : JSONSymbols.falseString
    }
    
    private func getNumberString(for num: Int) -> String {
        let convertedNumber = String(num)
        return convertedNumber
    }
    
}
