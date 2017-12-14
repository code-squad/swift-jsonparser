//
//  JSONDataFactory.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataFactory {
    var JSONParsingTarget : ParsingTarget
    
    init (_ JSONParsingTarget: ParsingTarget) {
        self.JSONParsingTarget = JSONParsingTarget
    }
    
    func setTargetType () -> JSONData {
        var parsedJSONData : JSONData
        
        switch JSONParsingTarget {
        case let JSONParsingTarget as MyArray:
            parsedJSONData = matchValueofArray(JSONParsingTarget)
        case let JSONParsingTarget as MyObject:
            parsedJSONData = matchValueOfObject(JSONParsingTarget)
        default:
            parsedJSONData = matchValueofArray(JSONParsingTarget)
        }
        return parsedJSONData
    }
    
    private func matchValueofArray (_ targets: ParsingTarget) -> JSONData {
        var parsedJSONData : [JSONData] = []
        
        for turn in 0..<targets.count() {
            if let boolValue = Bool(targets.getEachValue(turn)) {
                parsedJSONData.append(JSONData.BoolValue(boolValue))
                continue
            }
            if let intValue = Int(targets.getEachValue(turn)) {
                parsedJSONData.append(JSONData.IntegerValue(intValue))
                continue
            }
            if targets.getEachValue(turn).contains("\""){
                parsedJSONData.append(JSONData.StringValue(targets.getEachValue(turn)))
                continue
            }
        }
        return JSONData.ArrayValue(parsedJSONData)
    }

    
    private func matchValueOfObject (_ targets: MyObject) -> JSONData {
        var parsedJSONData : Dictionary<String, JSONData> = [:]
        
        for label in targets.getDictionary().keys {
            parsedJSONData[label] = matchValueType(targets.getDictionary()[label]!)
        }
        return JSONData.ObjectValue(parsedJSONData)
    }


    private func matchValueType (_ value: String) -> JSONData {
        if let boolValue = Bool(value) {
            return JSONData.BoolValue(boolValue)
        }
        if let intValue = Int(value) {
            return JSONData.IntegerValue(intValue)
        }
        if value.contains("\""){
            return JSONData.StringValue(value)
        }
        
        return JSONData.StringValue(value)
    }
    
}
