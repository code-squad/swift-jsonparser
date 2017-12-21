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
    // 입력받은 스트링을 타입에 따라 카운팅 인스턴스 생성반환
    static func makeCountedTypeInstance (_ stringValues: String) -> CountingData {
        var stringValues = stringValues
        if stringValues.removeFirst() == "{" {
            return makeObjectType(stringValues)
        } else {
            return makeArrayType(stringValues)
        }
    }
    
    // 객체타입의 카운팅 인스턴스 생성
    private static func makeObjectType(_ stringValues: String) -> CountingData {
        var object = [String:Any]()
        var objects = [Any]()
        let elementsOfObject = generateObjectElements(stringValues)
        object = (generateObject(elementsOfObject))
        objects.append(object)
        let (countOfNum, countOfBool, countOfString) = countOfValueTypeInObject(objects)
        return CountingData(countOfNum, countOfBool, countOfString, objects.count)
    }
    
    // 배열 타입의 카운팅 인스턴스 생성
    private static func makeArrayType(_ stringValues: String) -> CountingData {
        var numberValue = [Int]()
        var boolValue = [Bool]()
        var stringValue = [String]()
        var objects = [Any]()
        let stringValued = stringValues.trimmingCharacters(in: ["[","]"]).split(separator: ",").map { String($0)}
        _ = stringValued.forEach {
            if $0.starts(with: "{") && $0[$0.index(before: $0.endIndex)] == "}" { objects.append($0) }
            else if let integer = Int($0) { numberValue.append(integer)}
            else if let boolean = Bool($0) { boolValue.append(boolean)}
            else if  let firstString = $0.first, firstString == "\"" {stringValue.append($0)}
        }
        let totalCount = numberValue.count + boolValue.count + stringValue.count + objects.count
        return CountingData(ofNumericValue: numberValue.count, ofBooleanValue: boolValue.count, ofStringValue: stringValue.count, ofObject: objects.count, total: totalCount)
    }
    
    // 객체생성
    private static func generateObject(_ stringsInArray: Array<String>) -> [String:Any] {
        var jsonObject = [String:Any]()
        _ = stringsInArray.forEach {
            let keyValue = $0.split(separator: ":").map {$0.trimmingCharacters(in: .whitespaces)}
            let key : String = String(describing: keyValue.first ?? "").replacingOccurrences(of: "\"", with: "")
            let value : Any = generateValueInObject(stringNotyetValue: String(describing: keyValue.last ?? ""))
            jsonObject.updateValue(value, forKey: key)
        }
        return jsonObject
    }
    
    // 객체 내의 값의 타입 갯수를 세어 반환
    static func countOfValueTypeInObject(_ objects: [Any]) -> (countOfNum: Int, countOfBool: Int, countOfString: Int){
        var numberValue = [Int]()
        var boolValue = [Bool]()
        var stringValue = [String]()
        _ = objects.forEach {
            for object in $0 as! [String:Any] {
                if let integer =  object.value  as? Int {
                    numberValue.append(integer)
                }else if let boolean = object.value as? Bool {
                    boolValue.append(boolean)
                }else  { stringValue.append((object.value as? String ?? "")) }
            }
        }
        return (numberValue.count, boolValue.count, stringValue.count)
    }
    
    // 오브젝트 딕셔너리의 벨류생성
    private static func generateValueInObject(stringNotyetValue: String) -> Any {
        if stringNotyetValue.starts(with: "\"") { return stringNotyetValue.replacingOccurrences(of: "\"", with: "")}
        else if let interger = Int(stringNotyetValue) { return interger }
        else if let boolean = Bool(stringNotyetValue) { return boolean }
        else { return ""}
    }
    
    // 객체측정을 위해 최초입력값에서 "{","}" 제거
    private static func generateObjectElements(_ input: String) -> Array<String> {
        return input.trimmingCharacters(in: ["{","}"]).split(separator: ",").map {String($0)}
    }
}
