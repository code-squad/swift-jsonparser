//
//  SwiftType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String : SupportableInSetJSON {
    // 개별요소로 올 경우 문자열 화
    func createValueJSONString() -> String { return "\"\(self)\"" }
}
extension Bool : SupportableInSetJSON  {
    // 개별요소로 올 경우 문자열 화
    func createValueJSONString() -> String { return "\(self)" }
}
extension Int : SupportableInSetJSON {
    // 개별요소로 올 경우 문자열 화
    func createValueJSONString() -> String { return "\(self)" }
}
extension Dictionary : SupportableInSetJSON, SupportableJSON {
    // 객체 안의 지원하는 타입의 개수를 각각 셈
    func matchTypeForCounting() -> (Int, Int, Int, Int, Int, Int) {
        var valueSet : [SupportableInSetJSON] = []
        for (_, value) in self { valueSet.append(value as! SupportableInSetJSON) }
        return countType(allData: valueSet)
    }
    
    // 객체 프린트 문구 리턴
    func createTotalText(_ totalCount: Int) -> String {
        return "총 \(totalCount)개의 객체 데이터 중에 "
    }
    
    // Dictionary JSON 문자열 생성
    func createJSONString() -> String {
        var jsonText : String = "{\n"
        
        for (key, value) in self {
            guard let keyInSetJSON = key as? SupportableInSetJSON else { return "" }
            guard let valueInSetJSON = value as? SupportableInSetJSON else { return "" }
            jsonText = jsonText + "\t\(keyInSetJSON.createValueJSONString()) : \(valueInSetJSON.createValueJSONString()),\n"
        }
        jsonText.remove(at: jsonText.index(jsonText.endIndex, offsetBy: -2))
        jsonText = jsonText + "}"
        return jsonText
    }
    
    // 개별 요소로 올 경우 문자열 화
    func createValueJSONString() -> String {
        var keyInSetJSON : String
        var valueInSetJSON : String
        var jsonText : String = "{\n"
        
        for (key, value) in self {
            keyInSetJSON = (key as! SupportableInSetJSON).createValueJSONString()
            valueInSetJSON = (value as! SupportableInSetJSON).createValueJSONString()
            jsonText = jsonText + "\t\t\(keyInSetJSON) : \(valueInSetJSON),\n"
        }
        jsonText.remove(at: jsonText.index(jsonText.endIndex, offsetBy: -2))
        jsonText = jsonText + "\t}"
        return jsonText
    }
}

extension Array : SupportableInSetJSON, SupportableJSON {
    // 배열 안의 지원하는 타입의 개수를 각각 셈
    func matchTypeForCounting() -> (Int, Int, Int, Int, Int, Int) {
        return countType(allData: self as! [SupportableInSetJSON])
    }
    
    // 배열 프린트 문구 리턴
    func createTotalText(_ totalCount: Int) -> String {
        return "총 \(totalCount)개의 배열 데이터 중에 "
    }
    
    // Array JSON 문자열 생성
    func createJSONString() -> String {
        var lastSpace : Bool = false
        var jsonText : String = "["
        
        for index in 0..<self.count {
            guard let valueInArray = self[index] as? SupportableInSetJSON else { return "" }
            if index == 0 && self[index] is Array {
                jsonText = jsonText + "\n\t"
                lastSpace = true
            }
            else if index != 0 && self[index-1] is Array && self[index] is Array {
                jsonText = jsonText + "\n\t"
                lastSpace = true
            }
            else if index != 0 && self[index-1] is Dictionary<String, SupportableInSetJSON> && self[index] is Array {
                jsonText = jsonText + "\n\t"
                lastSpace = true
            }
            jsonText = jsonText + valueInArray.createValueJSONString() + ", "
        }
        jsonText.remove(at: jsonText.index(before: jsonText.endIndex))
        jsonText.remove(at: jsonText.index(before: jsonText.endIndex))
        if lastSpace { jsonText = jsonText + "\n]" }
        else { jsonText = jsonText + "]" }
        return jsonText
    }
    
    // 개별요소로 올 경우 문자열 화
    func createValueJSONString() -> String {
        return "\(self)"
    }
}

// 배열 안에 들어갈 수 있는 데이터 타입
protocol SupportableInSetJSON {
    // 개별요소로 올 경우 문자열 화
    func createValueJSONString() -> String
}
