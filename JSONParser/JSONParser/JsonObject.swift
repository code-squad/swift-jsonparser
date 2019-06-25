//
//  JsonObject.swift
//  JSONParser
//
//  Created by 이진영 on 14/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonObject: Countable {
    let object: [String : JsonType]
    
    var typeDescription: String {
        return TypeName.object.rawValue
    }
    
    var typeCount: [String : Int] {
        var typeCounter: [String : Int] = [:]
        
        for (_, value) in object {
            let typeName = String(describing: type(of: value))
            
            typeCounter[typeName] = (typeCounter[typeName] ?? 0) + 1
        }
        
        return typeCounter
    }
    
    func formatting(indent: Int) -> String {
        var result = ""
        var prefix = "\(JsonElement.startOfObject)\(JsonElement.newLine)"
        
        for (key, value) in object {
            result += "\(prefix)\(String(repeating: "\(JsonElement.tab)", count: indent + 1))"
            result += "\(key) : \(value.formatting(indent: indent + 1))"
            
            prefix = "\(JsonElement.comma)\(JsonElement.newLine)"
        }
        
        result += "\(JsonElement.newLine)\(String(repeating: "\(JsonElement.tab)", count: indent))\(JsonElement.endOfObject)"
        
        return result
    }
    
    init(object: [String : JsonType]) throws {
        if object.count == 0 {
            throw ParseError.noData
        }
        
        self.object = object
    }
}
