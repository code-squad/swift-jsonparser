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
    
    private static func makeJSONObject(from jsonString: String) -> JSONValue? {
        var jsonObject = [String: JSONValue]()
        let jsonStringTrimmedBrackets = jsonString.trimWhiteSpaces().trimCurlyBrackets()
        let jsonValues = jsonStringTrimmedBrackets.splitByComma()
        for jsonValue in jsonValues {
            guard jsonValue.contains(":") else { return nil }
            let objectKeyValue = jsonValue.splitByColon().map({ $0.trimWhiteSpaces() })
            guard objectKeyValue.count > 1 else { return nil }
            guard objectKeyValue[0].hasDoubleQuotation() else { return nil }
            let key: String = objectKeyValue[0].trimDoubleQuotation()
            guard let value: JSONValue = typeCast(from: objectKeyValue[1]) else { continue }
            jsonObject[key] = value
        }
        return JSONValue.object(jsonObject)
    }
    
    private static func makeJSONArray(from jsonString: String) -> JSONValue? {
        var jsonArray = [JSONValue]()
        let jsonStringTrimmedBrackes = jsonString.trimWhiteSpaces().trimSquareBrackets()
        let str = jsonStringTrimmedBrackes
        var iterateIndex = str.startIndex
        for index in str.indices {
            if (str[index]==",") {
                let a = String(str[iterateIndex..<index])
                guard let b = typeCast(from: a) else { continue }
                jsonArray.append(b)
                iterateIndex = str.index(after: index)
                continue
            } else if (str[index]=="{") {
                let a = str[iterateIndex...]
                guard let b = a.firstIndex(of: "}") else { return nil }
                let c = String(str[iterateIndex...b])
                guard let d = makeJSONObject(from: c) else { return nil}
                jsonArray.append(d)
                iterateIndex = str.index(after: index)
                continue
            } else if (index==str.endIndex) {
                let a = String(str[iterateIndex...index])
                guard let b = typeCast(from: a) else { continue }
                jsonArray.append(b)
                continue
            }
        }
        return JSONValue.array(jsonArray)
    }
    
    static func parse(_ jsonString: String) -> JSONValue? {
        if jsonString.hasSideSquareBrackets() { return makeJSONArray(from: jsonString) }
        if jsonString.hasSideCurlyBrackets() { return makeJSONObject(from: jsonString) }
        return nil
    }
}
