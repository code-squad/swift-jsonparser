//
//  Parse.swift
//  JSONParser
//
//  Created by oingbong on 2018. 8. 15..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JsonParse {
    public static func parseJsonObject(to jsonData:String) -> [String:JsonType] {
        var jsonObject = [String:JsonType]()
        
        if let regex = try? NSRegularExpression(pattern: Regex.objectPatternSmallObject){
            let string = jsonData as NSString
            
            let regexMatches = regex.matches(in: jsonData, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            for regexMatch in regexMatches {
                var key = ""
                var value = ""
                
                // key parse
                if let regexKey = try? NSRegularExpression(pattern: Regex.objectKeyPattern){
                    let string = regexMatch as NSString
                    
                    let keyRegexMatches = regexKey.matches(in: regexMatch, options: [], range: NSRange(location: 0, length: string.length)).map {
                        string.substring(with: $0.range)
                    }
                    
                    if keyRegexMatches.count > 0 {
                        key = keyRegexMatches[0]
                    }
                }
                // value parse
                if let regexValue = try? NSRegularExpression(pattern: Regex.objectValuePattern){
                    let string = regexMatch as NSString
                    
                    let valueRegexMatches = regexValue.matches(in: regexMatch, options: [], range: NSRange(location: 0, length: string.length)).map {
                        string.substring(with: $0.range)
                    }
                    
                    if valueRegexMatches.count > 0 {
                        value = valueRegexMatches[0]
                    }
                }
                
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
                
                // save [String:JsonType]
                if value.isObject() {
                    jsonObject.updateValue(JsonType.object(value), forKey: key)
                }else if value.isArray() {
                    jsonObject.updateValue(JsonType.array([JsonType.string(value)]), forKey: key)
                }else if value.isBool() {
                    jsonObject.updateValue(JsonType.bool(Bool(value)!), forKey: key)
                }else if value.isNumber() {
                    jsonObject.updateValue(JsonType.int(Int(value)!), forKey: key)
                }else {
                    jsonObject.updateValue(JsonType.string(value), forKey: key)
                }
                
            }
        }
        
        return jsonObject
    }
    
    public static func parseJsonArray(to jsonData:String) -> [JsonType] {
        var jsonArray = [JsonType]()
        
        if let regex = try? NSRegularExpression(pattern: Regex.arrayPatternSmallArray){
            let string = jsonData as NSString
            
            let regexMatches = regex.matches(in: jsonData, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range)
            }
            
            for regexMatch in regexMatches {
                if regexMatch.isObject() {
                    jsonArray.append(JsonType.object(regexMatch))
                }else if regexMatch.isArray() {
                    jsonArray.append(JsonType.array([JsonType.string(regexMatch)]))
                }else if regexMatch.isBool() {
                    jsonArray.append(JsonType.bool(Bool(regexMatch)!))
                }else if regexMatch.isNumber() {
                    jsonArray.append(JsonType.int(Int(regexMatch)!))
                }else {
                    jsonArray.append(JsonType.string(regexMatch))
                }
            }
        }
        
        return jsonArray
    }
}
