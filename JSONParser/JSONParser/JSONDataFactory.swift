//
//  JSONDataFactory.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataFactory {
    
    /*
    func setTargetType () -> JSONData {
        var parsedJSONData : JSONData
        
        switch JSONParsingTarget {
        case let JSONParsingTarget as MyArray:
            parsedJSONData = matchValueOfArray(JSONParsingTarget)
        case let JSONParsingTarget as MyObject:
            parsedJSONData = matchValueOfObject(JSONParsingTarget)
        default:
            parsedJSONData = matchValueOfArray(JSONParsingTarget)
        }
        return parsedJSONData
    }
    */
    
    func matchValueOfArray (_ targets: [String]) -> [JSONData] {
        var parsedJSONData : [JSONData] = []
        
        for value in targets {
            parsedJSONData.append(matchValueType(value))
        }
        return parsedJSONData
    }
    

    func matchValueOfObject (_ targets: Dictionary<String, String>) -> Dictionary<String, JSONData> {
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
        if value.contains("\""){
            return JSONData.StringValue(value)
        }
        if value.contains("{") {
            let myObject = MyObject(value)
            let tempDic = myObject.makeMyType()
            let parsedObject = matchValueOfObject(tempDic)
            return JSONData.ObjectValue(parsedObject)
        }
        return JSONData.StringValue(value)
    }
    
}
