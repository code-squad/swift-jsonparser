//
//  JSONGenerator.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private static func typeCast(from string: String) -> JSONValue? {
        if string.hasDoubleQuotation() { return JSONValue.string(string.trimDoubleQuotation()) }
        if let int = Int(string) { return JSONValue.int(int) }
        if let bool = Bool(string) { return JSONValue.bool(bool) }
        return nil
    }
    
    private static func extractKeyValue(from jsonValue: String) -> (key: String, value: JSONValue?)? {
        guard jsonValue.contains(":") else { return nil }
        let objectKeyValue = jsonValue.splitByColon().map({ $0.trimWhiteSpaces() })
        guard objectKeyValue.count > 1 else { return nil }
        guard objectKeyValue[0].hasDoubleQuotation() else { return nil }
        let key: String = objectKeyValue[0].trimDoubleQuotation()
        let value: JSONValue? = typeCast(from: objectKeyValue[1])
        return (key, value)
    }
    
    private static func makeJSONObject(from jsonString: String) -> [String: JSONValue]? {
        var jsonObject = [String: JSONValue]()
        let jsonStringTrimmedBrackets = jsonString.trimWhiteSpaces().trimCurlyBrackets()
        let jsonValues = jsonStringTrimmedBrackets.splitByComma()
        for jsonValue in jsonValues {
            guard let keyValue = extractKeyValue(from: jsonValue) else { return nil }
            guard let value: JSONValue = keyValue.value else { continue }
            jsonObject[keyValue.key] = value
        }
        return jsonObject
    }
    
    private static func makeJSONArray(from jsonString: String) -> [JSONValue]? {
        var jsonArray = [JSONValue]()
        let jsonString = jsonString.trimWhiteSpaces().trimSquareBrackets()
        var iterateIndex = jsonString.startIndex
        var sliceIndex = jsonString.startIndex
        while(iterateIndex != jsonString.endIndex) {
            if (jsonString[iterateIndex]=="{") {
                guard let closeBracketIndex = jsonString[iterateIndex...].firstIndex(of: "}") else { return nil }
                let slice = String(jsonString[sliceIndex...closeBracketIndex])
                guard let jsonObject = makeJSONObject(from: slice) else { return nil}
                jsonArray.append(JSONValue.object(jsonObject))
                iterateIndex = jsonString.index(after: jsonString[closeBracketIndex...].firstIndex(of: ",") ?? closeBracketIndex)
                sliceIndex = iterateIndex
                continue
            } else if (jsonString[iterateIndex] == ",") {
                let slice = String(jsonString[sliceIndex..<iterateIndex])
                guard let jsonValue = typeCast(from: slice.trimWhiteSpaces()) else { continue }
                jsonArray.append(jsonValue)
                iterateIndex = jsonString.index(after: iterateIndex)
                sliceIndex = iterateIndex
                continue
            } else if (iterateIndex==jsonString.index(before: jsonString.endIndex)) {
                let slice = String(jsonString[sliceIndex...])
                guard let jsonValue = typeCast(from: slice.trimWhiteSpaces()) else { continue }
                jsonArray.append(jsonValue)
            }
            iterateIndex = jsonString.index(after: iterateIndex)
        }
        return jsonArray
    }
    
    static func parse(_ jsonString: String) -> JSONDataForm? {
        if jsonString.hasSideSquareBrackets() {
            guard let jsonArray = makeJSONArray(from: jsonString) else { return nil }
            return JSONArray.init(jsonArray: jsonArray)
        }
        if jsonString.hasSideCurlyBrackets() {
            guard let jsonObject = makeJSONObject(from: jsonString) else { return nil }
            return JSONObject.init(jsonObject: jsonObject)
        }
        return nil
    }
}
