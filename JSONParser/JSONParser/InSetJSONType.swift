//
//  SwiftType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String : InSetJSONType {
    // 개별요소로 올 경우 문자열 화
    func printEachJSONString() -> String { return "\"\(self)\"" }
}
extension Bool : InSetJSONType  {
    // 개별요소로 올 경우 문자열 화
    func printEachJSONString() -> String { return "\(self)" }
}
extension Int : InSetJSONType {
    // 개별요소로 올 경우 문자열 화
    func printEachJSONString() -> String { return "\(self)" }
}
extension Dictionary : InSetJSONType, JSONType {
    // 객체 안의 지원하는 타입의 개수를 각각 셈
    func matchTypeForCounting() -> (Int, Int, Int, Int, Int, Int) {
        var valueSet : [InSetJSONType] = []
        for (_, value) in self { valueSet.append(value as! InSetJSONType) }
        return countType(allData: valueSet)
    }
    
    // 객체 프린트 문구 리턴
    func printTotalText(_ totalCount: Int) -> String {
        return "총 \(totalCount)개의 객체 데이터 중에 "
    }
    
    // Dictionary JSON 문자열 생성
    func createJSONStirng() -> String {
        var keyInSetJSON : String
        var valueInSetJSON : String
        var jsonText : String = "{\n"
        
        for (key, value) in self {
            keyInSetJSON = (key as! InSetJSONType).printEachJSONString()
            valueInSetJSON = (value as! InSetJSONType).printEachJSONString()
            jsonText = jsonText + "\t\(keyInSetJSON) : \(valueInSetJSON),\n"
        }
        jsonText.remove(at: jsonText.index(jsonText.endIndex, offsetBy: -2))
        jsonText = jsonText + "}"
        return jsonText
    }
    
    // 개별 요소로 올 경우 문자열 화
    func printEachJSONString() -> String {
        var keyInSetJSON : String
        var valueInSetJSON : String
        var jsonText : String = "{\n"
        
        for (key, value) in self {
            keyInSetJSON = (key as! InSetJSONType).printEachJSONString()
            valueInSetJSON = (value as! InSetJSONType).printEachJSONString()
            jsonText = jsonText + "\t\t\(keyInSetJSON) : \(valueInSetJSON),\n"
        }
        jsonText.remove(at: jsonText.index(jsonText.endIndex, offsetBy: -2))
        jsonText = jsonText + "\t}"
        return jsonText
    }
}

extension Array : InSetJSONType, JSONType {
    // 배열 안의 지원하는 타입의 개수를 각각 셈
    func matchTypeForCounting() -> (Int, Int, Int, Int, Int, Int) {
        return countType(allData: self as! [InSetJSONType])
    }
    
    // 배열 프린트 문구 리턴
    func printTotalText(_ totalCount: Int) -> String {
        return "총 \(totalCount)개의 배열 데이터 중에 "
    }
    
    // Array JSON 문자열 생성
    func createJSONStirng() -> String {
        var valueInArray : [InSetJSONType] = []
        var lastSpace : Bool = false
        var jsonText : String = "["
        
        for value in self { valueInArray.append(value as! InSetJSONType) }
        for index in 0..<valueInArray.count {
            if index == 0 && valueInArray[index] is Array {
                jsonText = jsonText + "\n\t"
                lastSpace = true
            }
            else if index != 0 && valueInArray[index-1] is Array && valueInArray[index] is Array {
                jsonText = jsonText + "\n\t"
                lastSpace = true
            }
            else if index != 0 && valueInArray[index-1] is Dictionary<String, InSetJSONType> && valueInArray[index] is Array {
                jsonText = jsonText + "\n\t"
                lastSpace = true
            }
            jsonText = jsonText + valueInArray[index].printEachJSONString() + ", "
        }
        jsonText.remove(at: jsonText.index(before: jsonText.endIndex))
        jsonText.remove(at: jsonText.index(before: jsonText.endIndex))
        if lastSpace { jsonText = jsonText + "\n]" }
        else { jsonText = jsonText + "]" }
        return jsonText
    }
    
    // 개별요소로 올 경우 문자열 화
    func printEachJSONString() -> String {
        return "\(self)"
    }
}

// 배열 안에 들어갈 수 있는 데이터 타입
protocol InSetJSONType {
    // 개별요소로 올 경우 문자열 화
    func printEachJSONString() -> String
}
