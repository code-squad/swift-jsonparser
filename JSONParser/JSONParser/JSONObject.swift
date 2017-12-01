//
//  JSONObjectData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 27..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

struct JSONObject: JSONData {
    private var jsonObject: [String:JSONType]

    init(_ value: [String:JSONType]) {
        self.jsonObject = value
    }

    func analyzeData() -> JSONAnalysisData {
        let jsonData = JSONAnalysisData(jsonObject)
        return jsonData
    }
    
    func countData() -> String {
        return "\(jsonObject.count)개의 객체"
    }
    
    func showJSONData(_ depth: Int) -> String {
        var resultJSON = String()
        resultJSON += "{"
        for (key, element) in jsonObject {
            switch element {
            case .arrayType(let value):
                resultJSON += "\n" + String(repeating: "\t", count: depth) + "\"" + key + "\"" + " : " + value.showJSONData(1)
            case .objectType(let value):
                resultJSON += "\n" + String(repeating: "\t", count: depth) + "\"" + key + "\"" + " : " + value.showJSONData(1)
            case .intType(let value):
                resultJSON += "\n" + String(repeating: "\t", count: depth) + "\"" + key + "\"" + " : " + String(value)
            case .boolType(let value):
                resultJSON += "\n" + String(repeating: "\t", count: depth) + "\"" + key + "\"" + " : " + String(value)
            case .stringType(let value):
                resultJSON += "\n" + String(repeating: "\t", count: depth) + "\"" + key + "\"" + " : " + "\"" + value + "\""
            }
            
            resultJSON += ","
        }
        resultJSON.removeLast()
        resultJSON += "\n" + String(repeating: "\t", count: depth-1) + "}"
        return resultJSON
    }
    
    static func lexData(_ value: String) throws -> [String] {
        let objectPattern = "((\"[^\"\"]*\")\\s*?:\\s*?((\\[[^\\[\\]]*\\])|(true|false)|(\\d+)|(\"[^\"\"]*\")|(\\{[^\\{\\}]*\\})))|(:)|(\\[|\\])"
        let rawJSON = value.removeFirstAndEnd()
        return try JSONLexer.listMatches(pattern: objectPattern, inString: rawJSON)
    }
    
    static func makeJSONFirstObjectData(_ value: String) throws -> JSONData {
        let rawValue = try lexData(value)
        guard GrammarChecker.checkElements(of: rawValue) else {
            throw ErrorCode.invalidJSONStandard
        }
        return try makeJSONData(rawValue)
    }
    
    static func makeJSONData(_ value: [String]) throws -> JSONData {
        var objectTypeJSON = [String:JSONType]()
        for objectComponents in value {
            let separateObject = objectComponents.components(separatedBy: ":")
            let trimmingKey = separateObject[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let key = trimmingKey.removeFirstAndEnd()
            let objectValue = separateObject[1].trimmingCharacters(in: .whitespacesAndNewlines)
            objectTypeJSON[key] = try JSONUtility.sortJSONData(objectValue)
        }
        return JSONObject(objectTypeJSON)
    }

}
