//
//  JSONAnalyzer.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 17..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray {
    private(set) var jsonArray: [String]
    private(set) var jsonDataType: JSONDataType = JSONDataType()
    
    init(data: [String], jsonDataType: JSONDataType) {
        self.jsonArray = data
        self.jsonDataType = JSONDataType(booleanTypeCount: jsonDataType.booleanTypeCount,
                                                 numberTypeCount: jsonDataType.numberTypeCount,
                                                 stringTypeCount: jsonDataType.stringTypeCount)
    }
}

