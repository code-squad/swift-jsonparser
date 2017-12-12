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
    
    func setTargetType () -> [JSONData] {
        var parsedJSONData : [JSONData] = []
        
        switch JSONParsingTarget {
        case let JSONParsingTarget as MyArray:
            parsedJSONData = matchValueType(JSONParsingTarget)
        case let JSONParsingTarget as MyObject:
            parsedJSONData = matchValueType(JSONParsingTarget)
        default:
            parsedJSONData = matchValueType(JSONParsingTarget)
        }
        return parsedJSONData
    }
    
    private func matchValueType (_ values: ParsingTarget) -> [JSONData] {
        var parsedJSONData : [JSONData] = []
        
        for turn in 0..<values.count() {
            if let boolValue = Bool(values.getEachValue(turn)) {
                parsedJSONData.append(JSONData.BoolValue(boolValue))
                continue
            }
            if let intValue = Int(values.getEachValue(turn)) {
                parsedJSONData.append(JSONData.IntegerValue(intValue))
                continue
            }
            if values.getEachValue(turn).contains("\""){
                parsedJSONData.append(JSONData.StringValue(values.getEachValue(turn)))
                continue
            }
        }
        return parsedJSONData
    }
    
}
