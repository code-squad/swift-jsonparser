//
//  JSONObjectData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 27..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

struct JSONObject: JSONAnalysisData {
    private (set) var jsonObject: [String:JSONType]
    var boolTypeCount: Int = 0
    var stringTypeCount: Int = 0
    var intTypeCount: Int = 0
    var objectTypeCount: Int = 0
    var arrayTypeCount: Int = 0
    var sumOfData: Int = 0
    
    init(_ value: [String:JSONType]) {
        self.jsonObject = value
        countJSONData()
    }
    
    mutating func countJSONData() {
        for (_ , indexOfJSONData) in jsonObject {
            switch indexOfJSONData {
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
