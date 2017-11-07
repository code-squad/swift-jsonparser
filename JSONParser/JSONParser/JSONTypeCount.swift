//
//  JSONTypeCount.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONTypeCount {
    static func calculateNumberOfType(_ values: [Value]) -> Dictionary<String, Int> {
        var arrayCount = 0
        var jsonObjectCount = 0
        var stringCount = 0
        var intCount = 0
        var boolCount = 0
        for value in values {
            switch value {
            case is JSONObject: jsonObjectCount += 1
            case is String: stringCount += 1
            case is Int: intCount += 1
            case is Bool: boolCount += 1
            case is [Value]: arrayCount += 1
            default: break
            }
        }
        return ["객체": jsonObjectCount,
                "문자열": stringCount,
                "숫자": intCount,
                "부울": boolCount,
                "배열": arrayCount]
    }

}
