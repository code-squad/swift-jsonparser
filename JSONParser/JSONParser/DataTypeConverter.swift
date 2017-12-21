//
//  DataTypeConverter.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct DataTypeConverter {
    
    func makeConvertedArray (_ targets: [String]) -> [JSONData] {
        var parsedJSONData : [JSONData] = []
        
        for value in targets {
            parsedJSONData.append(matchValueType(value))
        }
        return parsedJSONData
    }
 
   func makeConvertedObject (_ targets: Dictionary<String, String>) -> Dictionary<String, JSONData> {
        var parsedJSONData : Dictionary<String, JSONData> = [:]
        
        for key in targets.keys {
            parsedJSONData[key] = matchValueType(targets[key]!)
        }
        return parsedJSONData
    }

    func matchValueType (_ value: String) -> JSONData {
        if let boolValue = Bool(value) {
            return JSONData.BoolValue(boolValue)
        }
        if let intValue = Int(value) {
            return JSONData.IntegerValue(intValue)
        }
        if value.contains("{") {
            let parser = Parser()
            let targetObject = parser.setTargetToObject(value)
            return targetObject
        }
        if value.contains("[") {
            let parser = Parser()
            let targetArray = parser.setTargetToArray(value)
            return targetArray
        }
        return JSONData.StringValue(value)
    }
    
}
