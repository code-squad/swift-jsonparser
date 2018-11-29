//
//  SwiftType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String : SupportableInSetJSON {
    func createValueJSONString(tab: String) -> String {
        return "\(tab)\(self)"
    }
}
extension Bool : SupportableInSetJSON  {
    func createValueJSONString(tab: String) -> String {
        return "\(tab)\(self)"
    }
}
extension Int : SupportableInSetJSON {
    func createValueJSONString(tab: String) -> String {
        return "\(tab)\(self)"
    }
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
        var tab : String

        for (key, value) in self {
            guard let keyInSetJSON = key as? SupportableInSetJSON else { return "" }
            guard let valueInSetJSON = value as? SupportableInSetJSON else { return "" }
            if valueInSetJSON is Dictionary<String, SupportableInSetJSON> { tab = "\t\t" }
            else { tab = "" }
            jsonText = jsonText + "\t\(keyInSetJSON.createValueJSONString(tab: "")) : \(valueInSetJSON.createValueJSONString(tab: tab)),\n"
        }
        jsonText.remove(at: jsonText.index(jsonText.endIndex, offsetBy: -2))
        jsonText = jsonText + "}"
        return jsonText
    }
    
    // 내부요소로 올 경우 JSON 생성
    func createValueJSONString(tab: String) -> String {
        var jsonText : String = "{\n"
        
        for (key, value) in self {
            guard let keyInSetJSON = key as? SupportableInSetJSON else { return "" }
            guard let valueInSetJSON = value as? SupportableInSetJSON else { return "" }
            jsonText = jsonText + "\(tab)\(keyInSetJSON.createValueJSONString(tab: "")) : \(valueInSetJSON.createValueJSONString(tab: "")),\n"
        }
        jsonText.remove(at: jsonText.index(jsonText.endIndex, offsetBy: -2))
        if tab == "\t\t" { jsonText = jsonText + "\t}" }
        jsonText = jsonText + "}"
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
        var jsonText : String = "["
        var tab : String
        var inObjectDoubleSpace : Bool = false
        
        for index in 0..<self.count {
            if index == 0 && self[index] is Array { inObjectDoubleSpace = true }
            else if index != 0 && self[index] is Array && self[index-1] is Array { inObjectDoubleSpace = true }
            else if index != 0 && self[index] is Array && self[index-1] is Dictionary<String, SupportableInSetJSON> { inObjectDoubleSpace = true }
        }
        
        for index in 0..<self.count {
            guard let elementInArray = self[index] as? SupportableInSetJSON else { return "" }
            if index == 0 && self[index] is Array { tab = "\n\t" }
            else if index != 0 && self[index] is Array && self[index-1] is Array { tab = "\n\t" }
            else if index != 0 && self[index] is Array && self[index-1] is Dictionary<String, SupportableInSetJSON> { tab = "\n\t" }
            else if inObjectDoubleSpace && self[index] is Dictionary<String, SupportableInSetJSON> { tab = "\t\t" }
            else if self[index] is Dictionary<String, SupportableInSetJSON> { tab = "\t" }
            else { tab = "" }
            jsonText = jsonText + elementInArray.createValueJSONString(tab: tab)
            jsonText = jsonText + ", "
        }

        jsonText.remove(at: jsonText.index(before: jsonText.endIndex))
        jsonText.remove(at: jsonText.index(before: jsonText.endIndex))
        if inObjectDoubleSpace { jsonText = jsonText + "\n]" }
        else { jsonText = jsonText + "]" }
        
        return jsonText
    }
    
    func createValueJSONString(tab : String) -> String {
        return "\(tab)\(self)"
    }
}

// 배열 안에 들어갈 수 있는 데이터 타입
protocol SupportableInSetJSON {
    // 개별요소로 올 경우 문자열 화
    func createValueJSONString(tab : String) -> String
}
