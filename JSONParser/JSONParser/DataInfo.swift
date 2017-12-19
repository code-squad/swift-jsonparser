//
//  DataInfo.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct DataInfo {
    var countOfNumber = 0
    var countOfString = 0
    var countOfBool = 0
    var countOfObject = 0
    var countOfArray = 0
    
    mutating func increamenInt() {
        countOfNumber += 1
    }
    
    mutating func increamentString() {
        countOfString += 1
    }
    
    mutating func increamentBool() {
        countOfBool += 1
    }
    
    mutating func increamentDictionary() {
        countOfObject += 1
    }
    
    mutating func increamentArray() {
        countOfArray += 1
    }
    
}
