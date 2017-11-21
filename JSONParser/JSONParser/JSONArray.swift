//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray {
    private var jsonArray: [String]
    private var jsonDataType: JSONDataType = JSONDataType()
    
    init(data: [String], jsonDataType: JSONDataType) {
        self.jsonArray = data
        self.jsonDataType = JSONDataType(booleanTypeCount: jsonDataType[JSONDataType.TypeName.boolean.rawValue],
                                                 numberTypeCount: jsonDataType[JSONDataType.TypeName.number.rawValue],
                                                 stringTypeCount: jsonDataType[JSONDataType.TypeName.string.rawValue])
    }
    
    var count: Int {
        return jsonArray.count
    }
    
    var getJSONDataType: JSONDataType {
        return jsonDataType
    }
    
    subscript(i: Int) -> String {
        return jsonArray[i]
    }
}



