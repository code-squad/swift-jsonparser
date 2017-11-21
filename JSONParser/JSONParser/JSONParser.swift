//
//  JSONParser.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    static func analyzeJSONData(in value: String) throws -> JSONArray {
        let splitValue = Utility.removeFromFirstToEnd(in: value).split()
        
        guard splitValue.count > 0 else {
            throw InputView.Errors.emptyValue
        }
        
        return makeJSONArray(in: splitValue)
    }
    
    private static func makeJSONArray(in jsonData: [String]) -> JSONArray {
        var booleanTypeCount = 0
        var numberTypeCount = 0
        var stringTypeCount = 0
        
        for data in jsonData {
            if data.match(pattern: CaseJSONDataTypePattern.booleanType.pattern) {
                booleanTypeCount += 1
            } else if data.match(pattern: CaseJSONDataTypePattern.numberType.pattern) {
                numberTypeCount += 1
            } else if data.match(pattern: CaseJSONDataTypePattern.stringType.pattern){
                stringTypeCount += 1
            }
        }
        
        return JSONArray(data: jsonData, jsonDataType: JSONDataType(booleanTypeCount: booleanTypeCount, numberTypeCount: numberTypeCount, stringTypeCount: stringTypeCount))
    }
}
