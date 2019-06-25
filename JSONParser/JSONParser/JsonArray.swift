//
//  JsonArray.swift
//  JSONParser
//
//  Created by 이진영 on 24/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonArray: Countable {
    let array: [JsonType]
    
    var typeDescription: String {
        return TypeName.array.rawValue
    }
    
    var typeCount: [String : Int] {
        var typeCounter: [String : Int] = [:]
        
        for element in array {
            let typeName = String(describing: type(of: element))
            
            typeCounter[typeName] = (typeCounter[typeName] ?? 0) + 1
        }
        
        return typeCounter
    }
    
    func formatting(indent: Int) -> String {
        var result = "\(String(repeating: JsonElement.tab, count: indent))"
        var prefix = String(JsonElement.startOfArray)
        
        for value in array {
            if value is JsonArray {
                prefix += String(JsonElement.newLine)
            }
            
            result += "\(prefix)\(value.formatting(indent: indent + 1))"
            
            prefix = "\(JsonElement.comma)\(JsonElement.whitespace)"
        }
        
        if array.contains(where: { type(of: $0) == JsonArray.self }) {
            result += String(JsonElement.newLine)
        }
        
        result += String(JsonElement.endOfArray)
        
        return result
    }
    
    init(array: [JsonType]) throws {
        if array.count == 0 {
            throw ParseError.noData
        }
        
        self.array = array
    }
}
