//
//  JSONParser.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    static func analyzeJSONData(in value: String) throws -> JSONDataCountable & JSONDataMaker {
        let splitValue = Utility.removeFromFirstToEnd(in: value).split()
        
        guard splitValue.count > 0 else {
            throw InputView.Errors.emptyValue
        }
        
        return makeJSONArray(in: splitValue)
    }
    
    private static func makeJSONArray(in value: [String]) -> JSONArray {
        let jsonData = value.map({ (s: String) -> JSONData in
            if s.match(pattern: JSONDataTypePattern.bool.rawValue) {
                return JSONData(value: Bool(s) ?? false).makeJSONData()
            } else if s.match(pattern: JSONDataTypePattern.number.rawValue) {
                return JSONData(value: Double(s) ?? 0).makeJSONData()
            } else if s.match(pattern: JSONDataTypePattern.string.rawValue) {
                return JSONData(value: s).makeJSONData()
            } else {
                return JSONData.null
            }
        })
        
        return JSONArray(data: jsonData)
    }
}
