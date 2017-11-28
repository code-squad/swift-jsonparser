//
//  Utility.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct Utility {
    static func convertStringToJSONDataArray(in value: String) -> [JSONData] {
        let splitValues = removeFromFirstToEnd(in: value).splitUnits()
        let jsonData = splitValues.map({ (s: String) -> JSONData in
            return nextValue(s)
        })
        
        return jsonData
    }
    
    static func convertStringToJSONDataObject(in value: String) -> [String: JSONData] {
        let splitValues = removeFromFirstToEnd(in: value).splitUnits()
        let tupleBuilder = splitValues.map({ (s: String) -> (String, JSONData) in
            let arr = s.split(separator: ":").map(String.init)
            return (arr[0], nextValue(arr[1]))
        })
        
        var dictionaryBuilder = [String: JSONData]()
        tupleBuilder.forEach{ dictionaryBuilder[$0.0] = $0.1 }
        
        return dictionaryBuilder
    }
    
    private static func nextValue(_ s: String) -> JSONData {
        let value = s.trimmingCharacters(in: .whitespaces)
        if value.starts(with: "[") {
            return nextArray(value)
        } else if value.starts(with: "{") {
            return nextObject(value)
        } else if value.matchPatterns(pattern: JSONDataTypePattern.bool) {
            return nextBool(value)
        } else if value.matchPatterns(pattern: JSONDataTypePattern.number) {
            return nextNumber(value)
        } else if value.matchPatterns(pattern: JSONDataTypePattern.string) {
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
        let splitValues = removeFromFirstToEnd(in: s).splitUnits()
        let tupleBuilder = splitValues.map({ (s: String) -> (String, JSONData) in
            let arr = s.split(separator: ":").map(String.init)
            let k = arr[0]
            let v = arr[1].trimmingCharacters(in: .whitespaces)
            return (k, nextValue(v))
        })
        
        var dictionaryBuilder = [String: JSONData]()
        tupleBuilder.forEach{ dictionaryBuilder[$0.0] = $0.1 }
        
        return JSONData.object(dictionaryBuilder)
    }
    
    private static func nextArray(_ s: String) -> JSONData {
        let splitValues = removeFromFirstToEnd(in: s).splitUnits()
        let arrayBuilder = splitValues.map({ (s: String) -> JSONData in
            nextValue(s.trimmingCharacters(in: .whitespaces))
        })
        
        return JSONData.array(arrayBuilder)
    }
    
    private static func removeFromFirstToEnd(in value: String) -> String {
        let startIndex = value.index(value.startIndex, offsetBy: 1)
        let endIndex = value.index(value.endIndex, offsetBy: -1)
        return String(value[startIndex..<endIndex])
    }
}
