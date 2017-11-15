//
//  JSONData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//
import Foundation

struct JSONData {
    private (set) var jsonArray: [JSONType]
    private (set) var jsonObject: [String:JSONType]
    private (set) var boolTypeCount: Int
    private (set) var stringTypeCount: Int
    private (set) var intTypeCount: Int
    private (set) var objectTypeCount: Int
    private (set) var sumOfData: Int
    
    init() {
        self.boolTypeCount = 0
        self.stringTypeCount = 0
        self.intTypeCount = 0
        self.objectTypeCount = 0
        self.sumOfData = 0
        self.jsonArray = [JSONType]()
        self.jsonObject = [String:JSONType]()
    }
    
    init(_ value: [JSONType]) {
        self.init()
        self.jsonArray = value
        countJSONArray()
    }
    
    init(_ value: [String:JSONType]) {
        self.init()
        self.jsonObject = value
        countJSONObject()
    }
    
    mutating private func countJSONArray() {
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
            }
        }
        sumOfData = intTypeCount + stringTypeCount + boolTypeCount + objectTypeCount
    }
    
    mutating private func countJSONObject() {
        for (_, indexOfJSONData) in jsonObject {
            switch indexOfJSONData {
            case .intType:
                intTypeCount += 1
            case .boolType:
                boolTypeCount += 1
            case .stringType:
                stringTypeCount += 1
            case .objectType:
                objectTypeCount += 1
            }        }
        sumOfData = intTypeCount + stringTypeCount + boolTypeCount
    }
    
}
