//
//  JSONParser.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    static func analyzeJSONData(in value: String) throws -> JSONDataCountable {
        guard value.starts(with: "{") else {
            return makeJSONArray(in: value)
        }
        
        return makeJSONObject(in: value)
    }
    
    private static func makeJSONArray(in value: String) -> JSONArray {
        return JSONArray(data: Utility.convertStringToJSONDataArray(in: value))
    }
    
    private static func makeJSONObject(in value: String) -> JSONObject {
        return JSONObject(data: Utility.convertStringToJSONDataObject(in: value))
    }
}
