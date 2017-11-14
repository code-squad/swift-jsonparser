//
//  JSONData.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    private var jsonDataInArray: [Any]
    private var jsonDataInObject: [String:Any]
    private (set) var boolTypeCount: Int
    private (set) var stringTypeCount: Int
    private (set) var intTypeCount: Int
    private (set) var sumOfData: Int
    
    init() {
        self.jsonDataInArray = [Any]()
        self.jsonDataInObject = [String:Any]()
        self.boolTypeCount = 0
        self.stringTypeCount = 0
        self.intTypeCount = 0
        self.sumOfData = 0
    }
    
    init(_ value: [Any]) {
        self.init()
        self.jsonDataInArray = value
        countJSONData()
    }
    
    init(_ value: [String:Any]) {
        self.init()
        self.jsonDataInObject = value
        countObjectData()
    }

    private mutating func countJSONData() {
        for indexOfJSONData in jsonDataInArray {
            if indexOfJSONData is Int {
                intTypeCount += 1
            } else if indexOfJSONData is String {
                stringTypeCount += 1
            } else {
                boolTypeCount += 1
            }
        }
        sumOfData = intTypeCount + stringTypeCount + boolTypeCount
    }
    
    private mutating func countObjectData() {
        for (key, value) in jsonDataInObject {
            if value is Int {
                intTypeCount += 1
            } else if value is String {
                stringTypeCount += 1
            } else {
                boolTypeCount += 1
            }
        }
        sumOfData = intTypeCount + stringTypeCount + boolTypeCount
    }
    
}
