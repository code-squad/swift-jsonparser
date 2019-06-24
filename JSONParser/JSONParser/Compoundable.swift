//
//  Compoundable.swift
//  JSONParser
//
//  Created by Daheen Lee on 24/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Compoundable {
    var elementCount: Int { get }
    var elements: [JSONValue] { get }
    func formatted(indentLevel: Int) -> String
    func getFormatted(element: JSONValue, indent: Int) -> String
}

extension Compoundable {
    func getFormatted(element: JSONValue, indent: Int) -> String {
        switch element {
        case let compound as Compoundable :
            return "\(compound.formatted(indentLevel: indent))"
        default:
            return "\(element)"
        }
    }
}

extension Array: Compoundable where Element == JSONValue {
    var elementCount: Int {
        return self.count
    }
    
    var elements: [JSONValue] {
        return self
    }
    
    func formatted(indentLevel: Int) -> String {
        var arrayString = String()
        var prefix = "\(JSONSymbols.openBracket)"
        for element in self {
            arrayString += "\(prefix)\(getFormatted(element: element, indent: indentLevel))"
            prefix = JSONSymbols.seperator
        }
        arrayString += "\(JSONSymbols.closedBracket)"
        return arrayString
    }
}

extension Dictionary: Compoundable where Key == String, Value == JSONValue {
    var elementCount: Int {
        return self.count
    }
    
    var elements: [JSONValue] {
        return Array(self.values)
    }
    
    func formatted(indentLevel: Int) -> String {
        var objectString = String()
        var prefix = "\(JSONSymbols.openBrace)\(JSONSymbols.newline)"
        let seperator = "\(JSONSymbols.seperator)\(JSONSymbols.newline)"
        var indentation = String(repeating: JSONSymbols.tab, count: indentLevel + 1)
        for (key, value) in self {
            objectString += "\(prefix)\(indentation)\(key) : \(getFormatted(element: value, indent: indentLevel + 1))"
            prefix = seperator
        }
        indentation = String(repeating: JSONSymbols.tab, count: indentLevel)
        objectString += "\(JSONSymbols.newline)\(indentation)\(JSONSymbols.closedBrace)"
        return objectString
    }
}
