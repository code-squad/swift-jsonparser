//
//  OutputView.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printAnalyzeResult(_ jsonData: JSONData) {
        var typeCount: NumberOfType = (0,0,0,0,0)
        if jsonData.array.count == 1 {
            guard let object = jsonData.array[0] as? JSONObject else { return }
            print("총 \(object.dictionary.count) 개의 객체 데이터 중에", terminator: "")
            typeCount = countTypeOfValue(Array(object.dictionary.values))
        } else {
            print("총 \(jsonData.array.count) 개의 배열 데이터 중에", terminator: "")
            typeCount = countTypeOfValue(jsonData.array)
        }
        var typeDictionaryCount = JSONTypeCount()
        typeDictionaryCount.calculateNumberOfType(typeCount)
        for (type,count) in typeDictionaryCount.dictionary where count != 0 {
            print(" \(type) \(count)개", terminator: "")
        }
        print("가 포함되어 있습니다.")
    }
    
    private static func countTypeOfValue(_ values: [Value]) -> NumberOfType {
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
        return (jsonObjectCount,stringCount,intCount, boolCount, arrayCount)
    }
    
}



