//
//  JSONObject.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONObject {
    private(set) var stringObjects: [String]
    private(set) var intObjects: [Int]
    private(set) var boolObjects: [Bool]
    
    init() {
        self.boolObjects = [Bool]()
        self.stringObjects = [String]()
        self.intObjects = [Int]()
    }
    
    init(stringArray: [String], intArray: [Int], boolArray: [Bool]) {
        stringObjects = stringArray
        intObjects = intArray
        boolObjects = boolArray
    }
}

