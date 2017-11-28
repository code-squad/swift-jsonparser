//
//  JSONAnalysis.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 28..
//  Copyright © 2017년 Napster. All rights reserved.
//

import Foundation

struct JSONAnalysisData {
    private (set) var boolTypeCount: Int = 0
    private (set) var stringTypeCount: Int = 0
    private (set) var intTypeCount: Int = 0
    private (set) var objectTypeCount: Int = 0
    private (set) var arrayTypeCount: Int = 0
    private (set) var sumOfData: Int = 0
    
    init(_ jsonArray: [JSONType]) {
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
    
    init(_ jsonObject: [String:JSONType]) {
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
