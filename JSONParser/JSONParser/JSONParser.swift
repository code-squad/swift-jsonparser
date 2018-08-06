//
//  JSONParser.swift
//  JSONParser
//
//  Created by 이동건 on 03/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    struct JSONParsedResult {
        private (set) var totalDataCounts: Int
        private (set) var listOfStrings: [String]
        private (set) var listOfIntegers: [Int]
        private (set) var listOfBooleans: [Bool]
        
        init(listOfStrings: [String], listOfIntegers: [Int], listOfBooleans: [Bool]) {
            self.totalDataCounts = listOfStrings.count + listOfIntegers.count + listOfBooleans.count
            self.listOfStrings = listOfStrings
            self.listOfIntegers = listOfIntegers
            self.listOfBooleans = listOfBooleans
        }
    }
    
    static func result(from data: String) -> JSONParsedResult {
        return parse(from: removeAccessory(from: data))
    }
    
    private static func removeAccessory(from data: String) -> [String] {
        var target = data
        target = target.replacingOccurrences(of: " ", with: "")
        target = target.replacingOccurrences(of: "[", with: "")
        target = target.replacingOccurrences(of: "]", with: "")
        return target.split(separator: ",").map {String($0)}
    }
    
    private static func parse(from elements : [String]) -> JSONParsedResult{
        var strings: [String] = []
        var integers: [Int] = []
        var booleans: [Bool] = []
        elements.forEach {
            switch $0 {
            case let value where value.contains("\""):
                strings.append(value)
            case let value where Int(value) != nil:
                integers.append(Int(value)!)
            case let value where Bool(value) != nil:
                booleans.append(Bool(value)!)
            default: return
            }
        }
        return JSONParsedResult(listOfStrings: strings, listOfIntegers: integers, listOfBooleans: booleans)
    }
}
