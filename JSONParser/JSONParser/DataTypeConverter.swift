//
//  DataTypeConverter.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct DataTypeConverter {
    
    func makeConvertedArray (_ targets: [String]) throws -> [JSONData] {
        var parsedJSONData : [JSONData] = []
        
        for value in targets {
            do {
                let matchedValue = try matchValueType(value)
                parsedJSONData.append(matchedValue)
            } catch let error {
                throw error
            }
        }
        return parsedJSONData
    }
 
   func makeConvertedObject (_ targets: Dictionary<String, String>) throws -> Dictionary<String, JSONData> {
        var parsedJSONData : Dictionary<String, JSONData> = [:]
        for key in targets.keys {
            do {
                parsedJSONData[key] = try matchValueType(targets[key]!)
            } catch let error {
                throw error
            }
        }
        return parsedJSONData
    }

    func matchValueType (_ value: String) throws -> JSONData {
        let grammarChecker = GrammarChecker()
       
        if value.contains("{") {
            do {
                let target = try grammarChecker.execute(value)
                let parsedData = try Parser.matchValues(target)
                return parsedData
            } catch let error {
                throw error
            }
        }
        if value.contains("[") {
            do {
                let target = try grammarChecker.forNestedArray(value)
                let parsedData = try Parser.matchValues(target)
                return parsedData
            } catch let error {
                throw error
            }
        }
        if let boolValue = Bool(value) {
            return JSONData.BoolValue(boolValue)
        }
        if let intValue = Int(value) {
            return JSONData.IntegerValue(intValue)
        }
        
        return JSONData.StringValue(value)
    }

}
