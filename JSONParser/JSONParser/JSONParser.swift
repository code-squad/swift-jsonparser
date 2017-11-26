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

    func makeJSONData(_ value: String) throws -> JSONData {
        var rawJSON = [String]()
        let firstObjectJSON = try grammarChecker.flatJSON(Of: value)
        
        switch firstObjectJSON {
        case let .arrayType(array) :
            rawJSON = try lexer.listMatches(pattern: arrayPattern, inString: array)
            return try makeArrayJSONData(grammarChecker.checkElements(Of: rawJSON))
        case let .objectType(object) :
            rawJSON = try lexer.listMatches(pattern: objectPattern, inString: object)
            return try makeObjectJSONData(grammarChecker.checkElements(Of: rawJSON))
        default :
            throw ErrorCode.invalidJSONStandard
        }
    }
    
    private func sortJSONData(_ value: String) throws -> JSONType {
        let rawJSON = value
        if let boolType = Bool(rawJSON) { return JSONType.boolType(boolType) }
        if let intType = Int(rawJSON) { return JSONType.intType(intType) }
        if rawJSON.hasPrefix("{") {
            _ = try makeJSONData(rawJSON)
            return JSONType.objectType(rawJSON)
        }
        if rawJSON.hasPrefix("[") {
            _ = try makeJSONData(rawJSON)
            return JSONType.arrayType(rawJSON)
        }
        return JSONType.stringType(removeBrace(rawJSON))
    }
    
    private func makeArrayJSONData(_ value: [String]) throws -> JSONData {
        return try JSONData(value.map{ try sortJSONData($0) })
    }
    
    private func makeObjectJSONData(_ separateJSON: [String]) throws -> JSONData {
        var objectTypeJSON = [String:JSONType]()
        for objectComponents in separateJSON {
            let separateObject = objectComponents.components(separatedBy: ":")
            let key = removeBrace(separateObject[0].trimmingCharacters(in: .whitespacesAndNewlines))
            let objectValue = separateObject[1].trimmingCharacters(in: .whitespacesAndNewlines)
            objectTypeJSON[key] = try sortJSONData(objectValue)
        }
        return JSONData(objectTypeJSON)
    }
    
    private func removeBrace(_ value: String) -> String {
        var rawJSON = value
        rawJSON.removeFirst()
        rawJSON.removeLast()
        return rawJSON
    }

}
