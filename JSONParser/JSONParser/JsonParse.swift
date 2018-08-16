//
//  Parse.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 15..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonParse:Equatable {
    public static func parseJsonObject(to jsonData:String) -> [String:JsonType] {
        var jsonObject = [String:JsonType]()
        
        if let regex = try? NSRegularExpression(pattern: Regex.objectPatternSmallObject){
            let string = jsonData as NSString
            
            let regexMatches = regex.matches(in: jsonData, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            jsonObject = makeJsonObject(to: regexMatches)
        }
        
        return jsonObject
    }
    
    private static func makeJsonObject(to regexMatches:[String]) -> [String:JsonType] {
        var jsonObject = [String:JsonType]()
        
        for regexMatch in regexMatches {
            // key & value parse
            guard var key = parseKey(to: regexMatch) else { break }
            guard var value = parseValue(to: regexMatch) else { break }
            
            // trim Colon(:)
            (key , value) = trimColon(first: key, last: value)
            
            // save [String:JsonType]
            if value.isObject() {
                let object = makeObject(to: value)
                jsonObject.updateValue(JsonType.object(object), forKey: key)
            }else if value.isArray() {
                let array = makeArray(to: value)
                jsonObject.updateValue(JsonType.array(array), forKey: key)
            }else if value.isBool() {
                let bool = makeBool(to: value)
                jsonObject.updateValue(JsonType.bool(bool), forKey: key)
            }else if value.isNumber() {
                let int = makeInt(to: value)
                jsonObject.updateValue(JsonType.int(int), forKey: key)
            }else {
                jsonObject.updateValue(JsonType.string(value), forKey: key)
            }
            
        }
        
        return jsonObject
    }
    
    private static func trimColon(first:String , last:String) -> (String, String) {
        var key = first
        var value = last
        /*
         key,value 앞뒤에 붙은 : 제거
         1. 앞뒤 공백 제거
         2. : 제거
         3. 한번 더 앞뒤 공백 제거
         */
        key = key.trimmingCharacters(in: .whitespacesAndNewlines)
        value = value.trimmingCharacters(in: .whitespacesAndNewlines)
        key.removeLast()
        value.removeFirst()
        key = key.trimmingCharacters(in: .whitespacesAndNewlines)
        value = value.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return (key, value)
    }
    
    private static func parseKey(to regexMatch:String) -> String? {
        if let regexKey = try? NSRegularExpression(pattern: Regex.objectKeyPattern){
            let string = regexMatch as NSString
            let keyRegexMatches = regexKey.matches(in: regexMatch, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            if keyRegexMatches.count > 0 {
                return keyRegexMatches[0]
            }
        }

        return nil
    }
    
    private static func parseValue(to regexMatch:String) -> String? {
        if let regexValue = try? NSRegularExpression(pattern: Regex.objectValuePattern){
            let string = regexMatch as NSString
            let valueRegexMatches = regexValue.matches(in: regexMatch, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            if valueRegexMatches.count > 0 {
                return valueRegexMatches[0]
            }
        }
        
        return nil
    }
    
    public static func parseJsonArray(to jsonData:String) -> [JsonType] {
        var jsonArray = [JsonType]()
        
        if let regex = try? NSRegularExpression(pattern: Regex.arrayPatternSmallArray){
            let string = jsonData as NSString
            
            let regexMatches = regex.matches(in: jsonData, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            jsonArray = makeJsonArray(to: regexMatches)
        }
        
        return jsonArray
    }
    
    private static func makeJsonArray(to regexMatches:[String]) -> [JsonType] {
        var jsonArray = [JsonType]()
        
        for regexMatch in regexMatches {
            if regexMatch.isObject() {
                let object = makeObject(to: regexMatch)
                jsonArray.append(JsonType.object(object))
            }else if regexMatch.isArray() {
                let array = makeArray(to: regexMatch)
                jsonArray.append(JsonType.array(array))
            }else if regexMatch.isBool() {
                let bool = makeBool(to: regexMatch)
                jsonArray.append(JsonType.bool(bool))
            }else if regexMatch.isNumber() {
                let int = makeInt(to: regexMatch)
                jsonArray.append(JsonType.int(int))
            }else {
                jsonArray.append(JsonType.string(regexMatch))
            }
        }
        
        return jsonArray
    }
    
    private static func makeBool(to data:String) -> Bool {
        return Bool(data)!
    }
    
    private static func makeInt(to data:String) -> Int {
        return Int(data)!
    }
    
    private static func makeArray(to data:String) -> [JsonType] {
        return [JsonType.string(data)]
    }
    
    private static func makeObject(to data:String) -> [String:JsonType] {
        guard let key = parseKey(to: data) else { return [String:JsonType]() }
        guard let value = parseValue(to: data) else { return [String:JsonType]() }
        
        var object = [String:JsonType]()
        
        if value.isObject() {
            let smallObject = makeObject(to: value)
            object.updateValue(JsonType.object(smallObject), forKey: key)
        }else if value.isArray() {
            let array = makeArray(to: value)
            object.updateValue(JsonType.array(array), forKey: key)
        }else if value.isBool() {
            let bool = makeBool(to: value)
            object.updateValue(JsonType.bool(bool), forKey: key)
        }else if value.isNumber() {
            let int = makeInt(to: value)
            object.updateValue(JsonType.int(int), forKey: key)
        }else {
            object.updateValue(JsonType.string(value), forKey: key)
        }
        
        return object
    }
    
}
