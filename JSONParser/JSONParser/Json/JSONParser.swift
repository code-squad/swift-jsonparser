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
        guard value.hasPrefix("{") else {
            return makeJSONArray(in: value)
        }
        
        return makeJSONObject(in: value)
    }
    
    private static func makeJSONArray(in value: String) -> JSONArray {
        let splitValues = Utility.removeFromFirstToEnd(in: value).splitUnits()
        
        let jsonData = splitValues.map({ (s: String) -> JSONData in
            if s.matchPatterns(pattern: JSONDataTypePattern.bool) {
                return JSONData(value: Bool(s) ?? false).makeJSONData()
            } else if s.matchPatterns(pattern: JSONDataTypePattern.number) {
                return JSONData(value: Double(s) ?? 0).makeJSONData()
            } else if s.matchPatterns(pattern: JSONDataTypePattern.string) {
                return JSONData(value: s).makeJSONData()
            } else {
                return JSONData(value: s).makeJSONData()
            }
        })
        
        return JSONArray(data: jsonData)
    }
    
    private static func makeJSONObject(in value: String) -> JSONObject {
        return JSONObject()
    }
}
