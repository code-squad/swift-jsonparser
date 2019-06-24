//
//  JSONValue.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONValue {
    var typeDescription: String { get }
    func formatted(indentLevel: Int) -> String
}

extension Bool: JSONValue {
    var typeDescription: String { return "부울" }
    func formatted(indentLevel: Int) -> String {
        return "\(self)"
    }
}

extension Int: JSONValue {
    var typeDescription: String { return "숫자" }
    func formatted(indentLevel: Int) -> String {
        return "\(self)"
    }
}

extension String: JSONValue {
    var typeDescription: String { return "문자열" }
    func formatted(indentLevel: Int) -> String {
        return self
    }
}

extension Array: JSONValue where Element == JSONValue {
    var typeDescription: String { return "배열" }
    func formatted(indentLevel: Int) -> String {
        var arrayString = String()
        var prefix = "\(JSONSymbols.openBracket)"
        for element in self {
            arrayString += "\(prefix)\(element.formatted(indentLevel: indentLevel))"
            prefix = JSONSymbols.seperator
        }
        arrayString += "\(JSONSymbols.closedBracket)"
        return arrayString
    }
}

extension Dictionary: JSONValue where Key == String, Value == JSONValue {
    var typeDescription: String { return "객체" }
    func formatted(indentLevel: Int) -> String {
        var objectString = String()
        var prefix = "\(JSONSymbols.openBrace)\(JSONSymbols.newline)"
        let seperator = "\(JSONSymbols.seperator)\(JSONSymbols.newline)"
        var indentation = String(repeating: JSONSymbols.tab, count: indentLevel + 1)
        for (key, value) in self {
            objectString += "\(prefix)\(indentation)\(key) : \(value.formatted(indentLevel: indentLevel + 1))"
            prefix = seperator
        }
        indentation = String(repeating: JSONSymbols.tab, count: indentLevel)
        objectString += "\(JSONSymbols.newline)\(indentation)\(JSONSymbols.closedBrace)"
        return objectString
    }
}
