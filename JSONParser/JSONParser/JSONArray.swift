//
//  JSONData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONData {
    private (set) var jsonArray: [JSONType]
    
    init(_ value: [JSONType]) {
        self.jsonArray = value
    }
    
    func analyzeData() -> JSONAnalysisData {
        let jsonData = JSONAnalysisData(jsonArray)
        return jsonData
    }
    
    func countData() -> String {
        return "\(jsonArray.count)개의 배열"
    }
    
    func showJSONData(_ depth: Int) -> String {
        let objectDepth = depth
        var objectCount = 0
        var resultJSON = String()
        resultJSON += "["
        for element in 0..<jsonArray.count {
            switch jsonArray[element] {
            case .arrayType(let value):
                resultJSON += "\n\t" + value.showJSONData(objectDepth + 1)
            case .objectType(let value):
                resultJSON += value.showJSONData(objectDepth + 1)
                objectCount += 1
            case .intType(let value):
                resultJSON += String(value)
            case .boolType(let value):
                resultJSON += String(value)
            case .stringType(let value):
                resultJSON += "\"" + value + "\""
            }
            resultJSON += ","
            
        }
        resultJSON.removeLast()
        if objectCount > 0 {
            resultJSON += "\n]"
        } else {
            resultJSON += "]"
        }
        return resultJSON
    }

    static func lexData(_ value: String) throws -> [String] {
        let arrayPattern = "(\\[[^\\[\\]]*\\])|(\\{[^\\{\\}]*\\})|(true|false)|(\\d+)|(\".+?\")|(:)|(\\[|\\])"
        let rawJSON = value.removeFirstAndEnd()
        return try JSONLexer.listMatches(pattern: arrayPattern, inString: rawJSON)
    }
    
    static func makeJSONFirstObjectData(_ value: String) throws -> JSONData {
        let rawValue = try lexData(value)
        try GrammarChecker.checkElements(of: rawValue)
        return try makeJSONData(rawValue)
    }
    
    static func makeJSONData(_ value: [String]) throws -> JSONData {
        return try JSONArray(value.map{ try JSONUtility.sortJSONData($0) })
    }
    
    
}
