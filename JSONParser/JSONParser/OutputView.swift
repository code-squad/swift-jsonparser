//
//  OutputView.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    typealias NumberOfType = (jsonObject: Int, string: Int, int: Int, bool: Int)
    
    static func printAnalyzeResult(_ jsonData: JSONData) {
        
        var jsonObjectCount = 0
        var stringCount = 0
        var intCount = 0
        var boolCount = 0
        
        if jsonData.isArray {
            guard let array = jsonData.array else { return }
            print("총 \(array.count) 개의 배열 데이터 중에", terminator: "")
            for value in array {
                switch value {
                case is JSONObject: jsonObjectCount += 1
                case is String: stringCount += 1
                case is Int: intCount += 1
                case is Bool: boolCount += 1
                default: break
                }
            }

        } else {
            guard let object = jsonData.object else { return }
            print("총 \(object.dictionary.count) 개의 객체 데이터 중에", terminator: "")
            for value in object.dictionary.values {
                switch value {
                case is String: stringCount += 1
                case is Int: intCount += 1
                case is Bool: boolCount += 1
                default: break
                }
            }

        }
        if jsonObjectCount != 0  { print(" 객체 \(jsonObjectCount) 개", terminator: "") }
        if stringCount != 0  { print(" 문자열 \(stringCount) 개", terminator: "") }
        if intCount != 0  { print(" 숫자 \(intCount) 개", terminator: "") }
        if boolCount != 0 { print(" 부울 \(boolCount) 개", terminator: "") }
        print("가 포함되어 있습니다.")
    }
}
