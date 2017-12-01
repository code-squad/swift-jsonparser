//
//  JSONUtility.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 30..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

struct JSONUtility {
    
    static func sortJSONData(_ value: String) throws -> JSONType {
        let rawValue = value
        if let boolType = Bool(rawValue) {
            return JSONType.boolType(boolType)
        }
        if let intType = Int(rawValue) {
            return JSONType.intType(intType)
        }
        if rawValue.hasPrefix("[") {
            return try JSONType.arrayType(JSONArray.makeJSONFirstObjectData(rawValue) as! JSONArray)
        }
        if rawValue.hasPrefix("{") {
            return try JSONType.objectType(JSONObject.makeJSONFirstObjectData(rawValue) as! JSONObject) 
        }
        return JSONType.stringType(rawValue.removeFirstAndEnd())
        
    }
    
}
