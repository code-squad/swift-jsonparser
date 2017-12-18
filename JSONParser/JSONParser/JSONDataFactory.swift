//
//  JSONDataFactory.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataFactory {
    
    func makeConvertedData (_ targets: ConvertTarget) -> JSONData {
        var parsedJSONArray : [JSONData] = []
        var parsedJSONObject : Dictionary<String, JSONData> = [:]
        
        switch targets {
        case let targets as Array<String>:
            parsedJSONArray = makeConvertedArray(targets)
            return JSONData.ArrayValue(parsedJSONArray)
            
        case let targets as Dictionary<String,String>:
            parsedJSONObject = makeConvertedObject(targets)
            return JSONData.ObjectValue(parsedJSONObject)
            
        default:
            return JSONData.ArrayValue(parsedJSONArray)
        }
    }
    
    private func makeConvertedArray (_ targets: [String]) -> [JSONData] {
        var parsedJSONData : [JSONData] = []
        
        for value in targets {
            parsedJSONData.append(matchValueType(value))
        }
        return parsedJSONData
    }
 
   private func makeConvertedObject (_ targets: Dictionary<String, String>) -> Dictionary<String, JSONData> {
        var parsedJSONData : Dictionary<String, JSONData> = [:]
        
        for key in targets.keys {
            parsedJSONData[key] = matchValueType(targets[key]!)
        }
        return parsedJSONData
    }

    private func matchValueType (_ value: String) -> JSONData {
        if let boolValue = Bool(value) {
            return JSONData.BoolValue(boolValue)
        }
        if let intValue = Int(value) {
            return JSONData.IntegerValue(intValue)
        }
        if value.contains(":") {
            let myObject = MyObject(value)
            return myObject.makeJSONDataValues()
        }
        return JSONData.StringValue(value)
    }
    
}
