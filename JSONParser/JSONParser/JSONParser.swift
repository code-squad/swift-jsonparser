//
//  JSONParser.swift
//  JSONUnitTest
//
//  Created by rhino Q on 2018. 3. 29..
//  Copyright © 2018년 JK. All rights reserved.
//


import Foundation

struct JSONParser {
    
    static func parse(_ tokens:[Token]) -> (Int, Int, Int) {
        var numberCount = 0
        var stringCount = 0
        var boolCount = 0
        for token in tokens{
            switch token {
            case .string:
                stringCount += 1
            case .bool:
                boolCount += 1
            case .number:
                numberCount += 1
            }
        }
        
        return (stringCount, boolCount, numberCount)
    }
}
