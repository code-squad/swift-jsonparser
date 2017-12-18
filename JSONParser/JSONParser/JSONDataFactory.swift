//
//  JSONDataFactory.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataFactory {

    func convertValues (_ parseTarget: ParseTarget) -> JSONData {
        var parsedJSONData : JSONData
        
        switch parseTarget {
        case let parseTarget as MyArray:
           let parsedArray = makeConvertedArray(parseTarget.makeMyType())
           parsedJSONData = JSONData.ArrayValue(parsedArray)
            
        case let parseTarget as MyObject:
            let parsedObject = makeConvertedObject(parseTarget.makeMyType())
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
