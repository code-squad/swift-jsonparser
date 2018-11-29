//
//  InputMenu.swift
//  JSONParser
//
//  Created by 윤동민 on 21/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

// 사용자가 입력할 수 있는 데이터 타입 Ex) 배열, 객체
protocol SupportableJSON {
    func matchTypeForCounting() -> (Int, Int, Int, Int, Int, Int)
    func createTotalText(_ totalCount : Int) -> String
    func createJSONString() -> String
}

extension SupportableJSON {
    func countType(allData : [SupportableInSetJSON]) -> (Int, Int, Int, Int, Int, Int) {
        var typeCount : (total : Int, string : Int, number : Int, bool : Int, object : Int, array : Int) = (allData.count, 0, 0, 0, 0, 0)
        for eachData in allData {
            if eachData is String { typeCount.string += 1 }
            else if eachData is Bool { typeCount.bool += 1 }
            else if eachData is Int { typeCount.number += 1 }
            else if eachData is Array<SupportableInSetJSON> { typeCount.array += 1 }
            else { typeCount.object += 1 }
        }
        return typeCount
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
        let objectTabs : [String] = self.createElementTab()
        var index = 0
        
        for (key, value) in self {
            guard let keyInSetJSON = key as? SupportableInSetJSON else { return "" }
            guard let valueInSetJSON = value as? SupportableInSetJSON else { return "" }
            jsonText = jsonText + "\t\(keyInSetJSON.createValueJSONString(tab: "")) : \(valueInSetJSON.createValueJSONString(tab: objectTabs[index])),\n"
            index += 1
        }
        jsonText.remove(at: jsonText.index(jsonText.endIndex, offsetBy: -2))
        jsonText = jsonText + "}"
        return jsonText
    }
    
    // 각 요소별 \t 생성
    func createElementTab() -> [String] {
        var objectTabs : [String] = []
        for (_, value) in self {
            guard let valueInSetJSON = value as? SupportableInSetJSON else { return [] }
            if valueInSetJSON is Dictionary<String, SupportableInSetJSON> { objectTabs.append("\t\t") }
            else { objectTabs.append("") }
        }
        return objectTabs
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
        else { jsonText = jsonText + "}" }
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
        let isDoubleSpace = self.checkInArrayLastSpace()
        let arrayTabs = self.createElementTab(isDoubleSpace)
        
        for index in 0..<self.count {
            guard let elementInArray = self[index] as? SupportableInSetJSON else { return "" }
            jsonText = jsonText + elementInArray.createValueJSONString(tab: arrayTabs[index])
            jsonText = jsonText + ", "
        }
        jsonText.remove(at: jsonText.index(before: jsonText.endIndex))
        jsonText.remove(at: jsonText.index(before: jsonText.endIndex))
        if isDoubleSpace { jsonText = jsonText + "\n]" }
        else { jsonText = jsonText + "]" }
        return jsonText
    }
    
    // JSON 문자열을 생성할 때, 마지막 \n이 필요한지 검사
    func checkInArrayLastSpace() -> Bool {
        for index in 0..<self.count {
            if index == 0 && self[index] is Array { return true }
            else if index != 0 && self[index] is Array && self[index-1] is Array { return true }
            else if index != 0 && self[index] is Array && self[index-1] is Dictionary<String, SupportableInSetJSON> { return true }
        }
        return false
    }
    
    // 각 Array 요소별 Tab 생성
    func createElementTab(_ isDoubleSpace : Bool) -> [String] {
        var arrayTabs : [String] = []
        for index in 0..<self.count {
            if index == 0 && self[index] is Array { arrayTabs.append("\n\t") }
            else if self[index] is Array && self[index-1] is Array { arrayTabs.append("\n\t") }
            else if self[index] is Array && self[index-1] is Dictionary<String, SupportableInSetJSON> { arrayTabs.append("\n\t") }
            else if isDoubleSpace && self[index] is Dictionary<String, SupportableInSetJSON> { arrayTabs.append("\t\t") }
            else if self[index] is Dictionary<String, SupportableInSetJSON> { arrayTabs.append("\t") }
            else { arrayTabs.append("") }
        }
        return arrayTabs
    }
    
    
    // 내부요소로 올 경우 JSON 생성
    func createValueJSONString(tab : String) -> String {
        return "\(tab)\(self)"
    }
}

