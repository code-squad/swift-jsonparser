//
//  JSONParser.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    static func analyzeJSONData(in value: String) throws -> JSONDataCountable {
        guard value.hasPrefix(JSONDataTypePattern.leftBrace) else {
            return makeJSONArray(in: value)
        }
        
        return makeJSONObject(in: value)
    }
    
    private static func makeJSONArray(in value: String) -> JSONArray {
        return JSONArray(data: convertStringToJSONDataArray(in: value))
    }
    
    private static func makeJSONObject(in value: String) -> JSONObject {
        return JSONObject(data: convertStringToJSONDataObject(in: value))
    }
    
    private static func convertStringToJSONDataArray(in value: String) -> [JSONData] {
        var jsonScanner: JSONScanner = JSONScanner()
        let jsonData = jsonScanner.makeValues(value).map({ (s: String) -> JSONData in
            return JSONParser.nextValue(s)
        })
        
        return jsonData
    }
    
    private static func convertStringToJSONDataObject(in value: String) -> [String: JSONData] {
        var jsonScanner: JSONScanner = JSONScanner()
        let tupleBuilder = jsonScanner.makeValues(value).map({ (s: String) -> (String, JSONData) in
            let arr = s.split(separator: ":").map(String.init)
            return (arr[0], JSONParser.nextValue(arr[1]))
        })
        
        var jsonData = [String: JSONData]()
        tupleBuilder.forEach{ jsonData[$0.0] = $0.1 }
        
        return jsonData
    }
    
    static func nextValue(_ s: String) -> JSONData {
        let value = s.trimmingCharacters(in: .whitespaces)
        
        if value.hasPrefix(JSONDataTypePattern.leftSquareBracket) {
            return nextArray(value)
        } else if value.hasPrefix(JSONDataTypePattern.leftBrace) {
            return nextObject(value)
        } else if value.matchPatterns(pattern: JSONDataTypePattern.bool) {
            return nextBool(value)
        } else if value.matchPatterns(pattern: JSONDataTypePattern.number) {
            return nextNumber(value)
        } else if value.contains(JSONDataTypePattern.doubleQuotation) {
            return nextString(value)
        }
        
        return JSONData.null
    }
    
    private static func nextBool(_ s: String) -> JSONData {
        return JSONData.bool(Bool(s) ?? false)
    }
    
    private static func nextNumber(_ s: String) -> JSONData {
        return JSONData.number(Double(s) ?? 0)
    }
    
    private static func nextString(_ s: String) -> JSONData {
        return JSONData.string(s)
    }
    
    private static func nextObject(_ s: String) -> JSONData {
        var jsonScanner: JSONScanner = JSONScanner()
        let tupleBuilder = jsonScanner.makeValues(s).map({ (s: String) -> (String, JSONData) in
            let _s = s.trimmingCharacters(in: .whitespaces)
            let arr = _s.split(separator: ":").map(String.init)
            let k = arr[0].trimmingCharacters(in: .whitespaces)
            let v = arr[1].trimmingCharacters(in: .whitespaces)
            return (k, nextValue(v))
        })

        var dictionaryBuilder = [String: JSONData]()
        tupleBuilder.forEach{ dictionaryBuilder[$0.0] = $0.1 }

        return JSONData.object(dictionaryBuilder)
    }
    
    private static func nextArray(_ s: String) -> JSONData {
        var jsonScanner: JSONScanner = JSONScanner()
        let arrayBuilder: [JSONData] = jsonScanner.makeValues(s).map({ (s: String) -> JSONData in
            let _s = s.trimmingCharacters(in: .whitespaces)
            return nextValue(_s)
        })
        
        return JSONData.array(arrayBuilder)
    }
}
