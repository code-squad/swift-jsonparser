//
//  JSONParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private let arrayPattern = "(\\[[^\\[\\]]*\\])|(\\{[^\\{\\}]*\\})|(true|false)|(\\d+)|(\".+?\")|(:)|(\\[|\\])"
    private let objectPattern = "((\"[^\"\"]*\")\\s*?:\\s*?((\\[[^\\[\\]]*\\])|(true|false)|(\\d+)|(\"[^\"\"]*\")|(\\{[^\\{\\}]*\\})))|(:)|(\\[|\\])"
    private let grammarChecker = GrammarChecker()
    private let lexer = JSONLexer()

    func makeJSONData(_ value: String) throws -> Any {
        var rawJSON = [String]()
        let firstObjectJSON = try grammarChecker.flatJSON(of: value)
        
        switch firstObjectJSON {
        case let .arrayType(array) :
            rawJSON = try lexer.listMatches(pattern: arrayPattern, inString: array)
            return try makeArrayJSONData(grammarChecker.checkElements(of: rawJSON))
        case let .objectType(object) :
            rawJSON = try lexer.listMatches(pattern: objectPattern, inString: object)
            return try makeObjectJSONData(grammarChecker.checkElements(of: rawJSON))
        default :
            throw ErrorCode.invalidJSONStandard
        }
    }
    
    private func sortJSONData(_ value: String) throws -> JSONType {
        let rawJSON = value
        if let boolType = Bool(rawJSON) {
            return JSONType.boolType(boolType)
        }
        if let intType = Int(rawJSON) {
            return JSONType.intType(intType)
        }
        if rawJSON.hasPrefix("{") {
            _ = try makeJSONData(rawJSON)
            return JSONType.objectType(rawJSON)
        }
        if rawJSON.hasPrefix("[") {
            _ = try makeJSONData(rawJSON)
            return JSONType.arrayType(rawJSON)
        }
        return JSONType.stringType(rawJSON.removeBrace())
        
    }
    
    private func makeArrayJSONData(_ value: [String]) throws -> JSONArrayData {
        return try JSONArrayData(value.map{ try sortJSONData($0) })
    }
    
    private func makeObjectJSONData(_ separateJSON: [String]) throws -> JSONObjectData {
        var objectTypeJSON = [String:JSONType]()
        for objectComponents in separateJSON {
            let separateObject = objectComponents.components(separatedBy: ":")
            let trimmingKey = separateObject[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let key = trimmingKey.removeBrace()
            let objectValue = separateObject[1].trimmingCharacters(in: .whitespacesAndNewlines)
            objectTypeJSON[key] = try sortJSONData(objectValue)
        }
        return JSONObjectData(objectTypeJSON)
    }

}

extension String {
    
    func removeBrace() -> String {
        var rawJSON = self
        rawJSON.removeFirst()
        rawJSON.removeLast()
        return rawJSON
    }
    
}
