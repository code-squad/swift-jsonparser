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
        var typeCount: NumberOfType = (0,0,0,0)
        
        if jsonData.isArray {
            guard let array = jsonData.array else { return }
            print("총 \(array.count) 개의 배열 데이터 중에", terminator: "")
            typeCount = countTypeOfValue(array)
        } else {
            guard let object = jsonData.object else { return }
            print("총 \(object.dictionary.count) 개의 객체 데이터 중에", terminator: "")
            typeCount = countTypeOfValue(Array(object.dictionary.values))
        }
        if typeCount.jsonObject != 0  { print(" 객체 \(typeCount.jsonObject) 개", terminator: "") }
        if typeCount.string != 0  { print(" 문자열 \(typeCount.string) 개", terminator: "") }
        if typeCount.int != 0  { print(" 숫자 \(typeCount.int) 개", terminator: "") }
        if typeCount.bool != 0 { print(" 부울 \( typeCount.bool) 개", terminator: "") }
        print("가 포함되어 있습니다.")
    }
    
    private static func countTypeOfValue(_ values: [Any]) -> NumberOfType {
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
            default: break
            }
        }
        return (jsonObjectCount, stringCount, intCount, boolCount)
    }}
