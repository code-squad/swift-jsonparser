//
//  JSONParser.swift
//  JSONParser
//
//  Created by 이동건 on 03/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONKey: String {
    case String = "문자열"
    case Integer = "숫자"
    case Boolean = "부울"
}

struct JSONParser {
    struct JSONParsedResult {
        private (set) var totalDataCounts: Int
        private (set) var resultDict: [JSONKey:Int] = [:]
        
        init(listOfStrings: [String], listOfIntegers: [Int], listOfBooleans: [Bool]) {
            resultDict[.String] = listOfStrings.count
            resultDict[.Integer] = listOfIntegers.count
            resultDict[.Boolean] = listOfBooleans.count
            self.totalDataCounts = listOfStrings.count + listOfIntegers.count + listOfBooleans.count
        }
    }
    
    static func result(from data: String) -> [JSONParsedResult] {
        let objects = generateObjects(from: data)
        return objects.map {parse(from: removeAccessory(from: $0))}
    }
    
    private static func generateObjects(from data: String) -> [String] { // "[{..}, {..}]" ---> ["{..}", "{..}"]
        var target = data
        target = target.replacingOccurrences(of: " ", with: "")
        target = target.replacingOccurrences(of: "[", with: "")
        target = target.replacingOccurrences(of: "]", with: "")
        return splitByObject(from: target)
    }
    
    private static func splitByObject(from data: String) -> [String] { // "{...},{...},{...}" ---> ["{...}", "{...}", "{...}"]
        var target = data.components(separatedBy: "},{")
        
        if target.count == 1 {
            return target
        }
        
        target.enumerated().forEach {
            $0.offset % 2 == 0 ? target[$0.offset].insert("}", at: target[$0.offset].endIndex) : target[$0.offset].insert("{", at: target[$0.offset].startIndex)
        }
        return target
    }
    
    private static func removeAccessory(from data: String) -> [String] {
        var target = data
        target = target.replacingOccurrences(of: "{", with: "")
        target = target.replacingOccurrences(of: "}", with: "")
        return target.split(separator: ",").map {String($0)}
    }
    
    private static func parse(from elements : [String]) -> JSONParsedResult{
        var strings: [String] = []
        var integers: [Int] = []
        var booleans: [Bool] = []
        
        let values:[String] = elements.compactMap {
            let keyAndValues = $0.split(separator: ":")
            return keyAndValues.count == 2 ? String(keyAndValues[1]) : nil
        }
        
        values.forEach {
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
