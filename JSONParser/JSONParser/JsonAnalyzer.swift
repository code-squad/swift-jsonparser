//
//  JsonAnalyzer.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

// 입력값을 분석해서 타입 갯수 객체를 생성
struct Analyzer {
    static func makeCountedTypeInstance (_ stringValues: Array<String>) -> CountingData {
        if (stringValues.first ?? "").starts(with: "{") {
            return makeObjectType(stringValues)
        } else {
            return makeArrayType(stringValues)
        }
    }
    
    private static func makeObjectType(_ stringValues: [String]) -> CountingData {
        var numberValue = [Int]()
        var boolValue = [Bool]()
        var stringValue = [String]()
        var objectValues = [String:Any]()
        let tempString = stringValues.joined().trimmingCharacters(in: ["{","}"]).components(separatedBy: ",")
        objectValues = (generateObject(items: tempString))
        for object in objectValues {
            if let integer =  object.value  as? Int {
                numberValue.append(integer)
            }else if let boolean = object.value as? Bool {
                boolValue.append(boolean)
            }else  { stringValue.append((object.value as? String)!) }
        }
        return CountingData(ofNumericValue: numberValue, ofBooleanValue: boolValue, ofStringValue: stringValue, total: objectValues.count)
    }
    
    private static func makeArrayType(_ stringValues: [String]) -> CountingData {
        var numberValue = [Int]()
        var boolValue = [Bool]()
        var stringValue = [String]()
        var objects = [Any]()
        _ = stringValues.map {
            if $0.starts(with: "{") { objects.append(generateObject(items: generateObjectElements($0))) }
            if let integer = Int($0) { numberValue.append(integer)}
            if let boolean = Bool($0) { boolValue.append(boolean)}
            if $0.starts(with: "\""){ stringValue.append($0)}
        }
        let totalCount = numberValue.count + boolValue.count + stringValue.count + objects.count
        return CountingData(ofNumericValue: numberValue, ofBooleanValue: boolValue, ofStringValue: stringValue, ofObject: objects, total: totalCount)
    }
    
    // 객체생성
    private static func generateObject(items: Array<String>) -> [String:Any] {
        var jsonObject = [String:Any]()
        _ = items.map {
            let keyValue = $0.split(separator: ":").map {$0.trimmingCharacters(in: .whitespaces)}
            let key : String = String(describing: keyValue.first ?? "").replacingOccurrences(of: "\"", with: "")
            let value : Any = generateValueInObject(item: String(describing: keyValue.last ?? ""))
            jsonObject.updateValue(value, forKey: key)
        }
        return jsonObject
    }
    
    // 오브젝트 딕셔너리의 벨류생성
    private static func generateValueInObject(item: String) -> Any {
        if item.starts(with: "\"") { return item.replacingOccurrences(of: "\"", with: "")}
        else if let interger = Int(item) { return interger }
        else if let boolean = Bool(item) { return boolean }
        else { return ""}
    }
    
    // 객체 입력값에서 { , } 제거
    private static func generateObjectElements(_ input: String) -> Array<String> {
        return input.trimmingCharacters(in: ["{","}"]).components(separatedBy: ",")
    }
}

