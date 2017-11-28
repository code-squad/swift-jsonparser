//
//  JSONData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONAnalysisData {
    private (set) var jsonArray: [JSONType]
    var boolTypeCount: Int = 0
    var stringTypeCount: Int = 0
    var intTypeCount: Int = 0
    var objectTypeCount: Int = 0
    var arrayTypeCount: Int = 0
    var sumOfData: Int = 0
    
    init(_ value: [JSONType]) {
        self.jsonArray = value
        countJSONData()
    }
    
    mutating func countJSONData() {
        for elementOfJSONArray in jsonArray {
            switch elementOfJSONArray {
            case .intType:
                intTypeCount += 1
            case .boolType:
                boolTypeCount += 1
            case .stringType:
                stringTypeCount += 1
            case .objectType:
                objectTypeCount += 1
            case .arrayType:
                arrayTypeCount += 1
            }
        }
        sumOfData = intTypeCount + boolTypeCount + stringTypeCount + objectTypeCount + arrayTypeCount
    }
    
}
