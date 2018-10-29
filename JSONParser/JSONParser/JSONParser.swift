//
//  JSONGenerator.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {

    private static func captureGroup(in string: String, by pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let range = NSRange(string.startIndex..., in: string)
        let matches = regex.matches(in: string, options: [], range: range)
        return matches.map { String(string[Range($0.range, in: string)!]) }
    }

    private static func typeCast(from string: String) -> JSONValue? {
        if string.hasSideCurlyBrackets() {
            guard let jsonObject = makeJSONObject(from: string) else { return nil }
            return JSONValue.object(JSONObject.init(jsonObject))
        }
        if string.hasDoubleQuotation() {
            return JSONValue.string(string.trimDoubleQuotation())
        }
        if let int = Int(string) {
            return JSONValue.int(int)
        }
        if let bool = Bool(string) {
            return JSONValue.bool(bool)
        }
        return nil
    }

    private static func extractKeyValue(from jsonValue: String) -> (key: String, value: JSONValue?) {
        let objectKeyValue = jsonValue.splitByColon().map { $0.trimWhiteSpaces() }
        let key: String = objectKeyValue[0].trimDoubleQuotation()
        let value: JSONValue? = typeCast(from: objectKeyValue[1])
        return (key, value)
    }

    private static func makeJSONObject(from jsonString: String) -> [String: JSONValue]? {
        var jsonObject = [String: JSONValue]()
        let keyValues = captureGroup(in: jsonString, by: JSONRegex.keyValue)
        guard keyValues.count == jsonString.splitByComma().count else { return nil }
        for keyValue in keyValues {
            let keyValueSplit = extractKeyValue(from: keyValue)
            guard let value: JSONValue = keyValueSplit.value else { continue }
            jsonObject[keyValueSplit.key] = value
        }
        return jsonObject
    }

    private static func makeJSONArray(from jsonString: String) -> [JSONValue]? {
        var jsonArray = [JSONValue]()
        let jsonValues = captureGroup(in: jsonString, by: JSONRegex.valuesIncludingObject)
        for jsonValue in jsonValues {
            guard let jsonValueConverted = typeCast(from: jsonValue) else { return nil }
            jsonArray.append(jsonValueConverted)
        }
        return jsonArray
    }

    static func parse(_ jsonString: String) -> JSONDataForm? {
        let jsonString = jsonString.trimWhiteSpaces()
        if jsonString.hasSideSquareBrackets() {
            guard GrammarChecker.isValid(jsonString, for: JSONRegex.jsonArray) else { return nil }
            guard let jsonArray = makeJSONArray(from: jsonString) else { return nil }
            return JSONArray.init(jsonArray)
        }
        if jsonString.hasSideCurlyBrackets() {
            guard GrammarChecker.isValid(jsonString, for: JSONRegex.jsonObject) else { return nil }
            guard let jsonObject = makeJSONObject(from: jsonString) else { return nil }
            return JSONObject.init(jsonObject)
        }
        return nil
    }

}
