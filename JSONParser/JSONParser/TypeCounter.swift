//
//  TypeCounter.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct TypeCounter {
    static func getTotalTypeCount(of values: [JSONValue]) -> [(String, Int)] {
        let boolCount   = countBool(in: values)
        let numberCount = countNumber(in: values)
        let stringCount = countString(in: values)
        
        var totalCountPair: [(String, Int)] = []
        totalCountPair.append((Bool.typeDescription, boolCount))
        totalCountPair.append((Int.typeDescription, numberCount))
        totalCountPair.append((String.typeDescription, stringCount))
        return totalCountPair
    }
    
    static func countBool(in values: [JSONValue]) -> Int {
        let boolElements = values.filter({ value in value is Bool })
        return boolElements.count
    }
    
    static func countNumber(in values: [JSONValue]) -> Int {
        let numberElements = values.filter({ value in value is Int })
        return numberElements.count
    }
    
    static func countString(in values: [JSONValue]) -> Int {
        let stringElements = values.filter({ value in value is String })
        return stringElements.count
    }
}
