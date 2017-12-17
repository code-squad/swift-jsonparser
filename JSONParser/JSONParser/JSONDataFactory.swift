//
//  JSONDataFactory.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataFactory {

    func convertValues (_ parsingTarget: ParsingTarget) -> JSONData {
        var parsedJSONData : JSONData
        
        switch parsingTarget {
        case let parsingTarget as MyArray:
           let parsedArray = makeConvertedArray(parsingTarget.makeMyType())
           parsedJSONData = JSONData.ArrayValue(parsedArray)
            
        case let parsingTarget as MyObject:
            let parsedObject = makeConvertedObject(parsingTarget.makeMyType())
            parsedJSONData = JSONData.ObjectValue(parsedObject)
        default:
            let parsedArray = makeConvertedArray([])
            parsedJSONData = JSONData.ArrayValue(parsedArray)
        }
        return parsedJSONData
    }
    
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
        if value.contains(":") {
            let myObject = MyObject(value)
            let tempDic = myObject.makeMyType()
            let parsedObject = makeConvertedObject(tempDic)
            return JSONData.ObjectValue(parsedObject)
        }
        return JSONData.StringValue(value)
    }
    
}
