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
        guard value.count > 0 else {
            throw JSONError.emptyValue
        }
        
        if value.hasPrefix(JSONDataTypePattern.leftBrace) {
            return try makeJSONObject(in: value)
        }
        
        return try makeJSONArray(in: value)
    }
    
    private static func makeJSONArray(in value: String) throws -> JSONArray {
        return JSONArray(data: try convertStringToJSONDataArray(in: value))
    }
    
    private static func makeJSONObject(in value: String) throws -> JSONObject {
        return JSONObject(data: try convertStringToJSONDataObject(in: value))
    }
    
    private static func convertStringToJSONDataArray(in value: String) throws -> [JSONData] {
        var jsonScanner: JSONScanner = JSONScanner()
        let jsonData = try jsonScanner.makeValues(value).map({ (s: String) -> JSONData in
            return try JSONParser.nextValue(s)
        })
        
        guard GrammerChecker.searchJSONDataNull(jsonData) else {
            throw JSONError.notDataConversation
        }
        
        return jsonData
    }
    
    private static func convertStringToJSONDataObject(in value: String) throws -> [String: JSONData] {
        var jsonScanner: JSONScanner = JSONScanner()
        let tupleBuilder = try jsonScanner.makeValues(value).map({ (s: String) -> (String, JSONData) in
            let arr = s.split(separator: ":").map(String.init)
            return (arr[0], try JSONParser.nextValue(arr[1]))
        })
        
        var jsonData = [String: JSONData]()
        tupleBuilder.forEach{ jsonData[$0.0] = $0.1 }
        
        guard GrammerChecker.searchJSONDataNull(Array(jsonData.values)) else {
            throw JSONError.notDataConversation
        }
        
        return jsonData
    }
    
    static func nextValue(_ s: String) throws -> JSONData {
        let value = s.trimmingCharacters(in: .whitespaces)
        
        if try value.matchPatterns(pattern: JSONDataTypePattern.array) {
            return try nextArray(value)
        } else if try value.matchPatterns(pattern: JSONDataTypePattern.object) {
            return try nextObject(value)
        } else if try value.matchPatterns(pattern: JSONDataTypePattern.bool) {
            return nextBool(value)
        } else if try value.matchPatterns(pattern: JSONDataTypePattern.number) {
            return nextNumber(value)
        } else if try value.matchPatterns(pattern: JSONDataTypePattern.string) {
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
    
    private static func nextObject(_ s: String) throws -> JSONData {
        var jsonScanner: JSONScanner = JSONScanner()
        let tupleBuilder = try jsonScanner.makeValues(s).map({ (s: String) -> (String, JSONData) in
            let _s = s.trimmingCharacters(in: .whitespaces)
            let arr = _s.split(separator: ":").map(String.init)
            let k = arr[0].trimmingCharacters(in: .whitespaces)
            let v = arr[1].trimmingCharacters(in: .whitespaces)
            return (k, try nextValue(v))
        })

        var dictionaryBuilder = [String: JSONData]()
        tupleBuilder.forEach{ dictionaryBuilder[$0.0] = $0.1 }

        return JSONData.object(dictionaryBuilder)
    }
    
    private static func nextArray(_ s: String) throws -> JSONData {
        var jsonScanner: JSONScanner = JSONScanner()
        let arrayBuilder: [JSONData] = try jsonScanner.makeValues(s).map({ (s: String) -> JSONData in
            let _s = s.trimmingCharacters(in: .whitespaces)
            return try nextValue(_s)
        })
        
        return JSONData.array(arrayBuilder)
    }
}
