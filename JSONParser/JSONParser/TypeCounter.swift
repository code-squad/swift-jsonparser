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
        var boolCount = 0,  numberCount = 0, stringCount = 0
        for value in values {
            switch value {
            case is Bool:
                boolCount += 1
            case is Int:
                numberCount += 1
            case is String:
                stringCount += 1
            default:
                break
            }
        }
        return createTotalCountPair(boolCount: boolCount, numberCount: numberCount, stringCount: stringCount)
    }
    
    static private func createTotalCountPair(boolCount: Int, numberCount: Int, stringCount: Int) -> [(String, Int)] {
        var totalCountPair: [(String, Int)] = []
        totalCountPair.append((Bool.typeDescription, boolCount))
        totalCountPair.append((Int.typeDescription, numberCount))
        totalCountPair.append((String.typeDescription, stringCount))
        return totalCountPair
    }
}
