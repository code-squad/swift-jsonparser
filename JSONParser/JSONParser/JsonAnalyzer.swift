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
    // Mark : 카운팅된 인스턴스 생성을 위한 작업
    static func makeCountedTypeInstance (_ stringValues: String) -> CountingData {
        if stringValues.first == "{" {
            return makeObjectType(stringValues)
        } else {
            return makeArrayType(stringValues)
        }
    }
    
    //  객체타입의 카운팅 인스턴스 생성
    private static func makeObjectType(_ stringValues: String) -> CountingData {
        var object = [String:Any]()
        var objects = [Any]()
        let elementsOfObject = getElementsOfObject(from: stringValues) // 스트링을 문법에 맞게 배열로 자름
        object = (generateObject(elementsOfObject))
        objects.append(object)
        let (countOfNum, countOfBool, countOfString, countOfArray) = countOfValueTypeInObject(objects)
        return CountingData(countOfNum, countOfBool, countOfString, countOfArray)
    }
    
    //  배열 타입의 카운팅 인스턴스 생성
    private static func makeArrayType(_ stringValues: String) -> CountingData {
        var numberValue = [Int]()
        var boolValue = [Bool]()
        var stringValue = [String]()
        var objects = [String]()
        var array = [String]()
        let elementsOfArray = getElementsFromArray(with: stringValues)
        _ = elementsOfArray.forEach {
            if $0.hasPrefix("{") && $0.hasSuffix("}") { objects.append($0) }
            else if $0.hasPrefix("[") && $0.hasSuffix("]") { array.append($0) }
            else if let integer = Int($0) { numberValue.append(integer)}
            else if let boolean = Bool($0) { boolValue.append(boolean)}
            else if  let firstString = $0.first, firstString == "\"" {stringValue.append($0)}
        }
        return CountingData(numberValue.count, boolValue.count, stringValue.count, objects.count, array.count)
    }
    
    //  Mark : 객체 카운팅 인스턴스 생성을 위한 작업
    // 객체타입 생성
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
    
    //  객체 내의 값의 타입 갯수를 세어 반환
    static func countOfValueTypeInObject(_ objects: [Any]) -> (countOfNum: Int, countOfBool: Int, countOfString: Int, countOfArray: Int){
        var numberValue = [Int]()
        var boolValue = [Bool]()
        var stringValue = [String]()
        var arrayValue = [String]()
        _ = objects.forEach {
            for object in $0 as! [String:Any] {
                if let integer =  object.value  as? Int {
                    numberValue.append(integer)
                } else if let stringLikeArray = object.value as? String, stringLikeArray.contains("[") {
                    arrayValue.append(stringLikeArray)
                } else if let boolean = object.value as? Bool {
                    boolValue.append(boolean)
                }else if object.value is String { stringValue.append(object.value as! String) }
            }
        }
        return (numberValue.count, boolValue.count, stringValue.count, arrayValue.count)
    }
    
    //  객체 내의 벨류생성
    private static func generateValueInObject(stringNotyetValue: String) -> Any {
        if stringNotyetValue.hasPrefix("[") && stringNotyetValue.hasSuffix("]") { return stringNotyetValue }
        else if stringNotyetValue.starts(with: "\"") { return stringNotyetValue.replacingOccurrences(of: "\"", with: "")}
        else if let interger = Int(stringNotyetValue) { return interger }
        else if let boolean = Bool(stringNotyetValue) { return boolean }
        else { return ""}
    }
    
    // Mark : 배열 카운팅 인스턴스 생성을 위한 작업
    //  입력된 스트링값을 각 문법규칙에 맞게 배열로 변환
    private static func getElementsFromArray(with target: String) -> Array<String> {
        var elementsFromArray : Array<String> = []
        var initialValue = target
        initialValue.removeFirst()
        initialValue.removeLast()
            if initialValue.contains("{") {elementsFromArray.append(getObjectMatches(from: initialValue))
                initialValue = initialValue.replacingOccurrences(of: getObjectMatches(from: initialValue), with: "")
            }
            if initialValue.contains("[") {elementsFromArray.append(getArrayMatches(from: initialValue))
                initialValue = initialValue.replacingOccurrences(of: getArrayMatches(from: initialValue), with: "")
            }
            elementsFromArray.append(contentsOf: getElementsOfValue(from: initialValue))
        
        return elementsFromArray
    }
    
    // Mark : 배열 및 객체 각각의 세부 값 추출 (스트링으로 추출됨)
    // 배열 내부의 객체 추출
    private static func getObjectMatches(from target: String) -> String {
        let leftBrace = target.index(of: "{") ?? target.endIndex
        let rightBrace = target.index(of: "}") ?? target.endIndex
        return String(target[leftBrace...rightBrace])
    }
    
    // 배열 내부의 배열 추출
    private static func getArrayMatches(from target: String) -> String {
        let leftSquareBracket = target.index(of: "[") ?? target.endIndex
        let rightSquareBracket = target.index(of: "]") ?? target.endIndex
        return String(target[leftSquareBracket...rightSquareBracket])
    }
    
    // 배열내부의 배열,객체 제외한 값 추출
    private static func getElementsOfValue(from target: String) -> Array<String> {
        return getElementsOfMatchedWIthJsonGrammer(inputValue: target, pattern: JsonGrammerRule.value)
    }
    
    // Mark : 객체 내부의 값 추출
    // 객체 내부에서 카운팅할 값들 추출
    private static func getElementsOfObject(from target: String) -> Array<String> {
        return getElementsOfMatchedWIthJsonGrammer(inputValue: target, pattern: JsonGrammerRule.ofNestedArray)
    }
    
    // Mark : 문법과 매칭할 NS함수
    private static func getElementsOfMatchedWIthJsonGrammer(inputValue: String, pattern: String) -> Array<String> {
        let regularExpression = try! NSRegularExpression.init(pattern: pattern, options: [])
        let objectResult = regularExpression.matches(in: inputValue, options: [], range: NSRange(location:0, length:inputValue.count))
        let result = objectResult.map {String(inputValue[Range($0.range, in: inputValue)!])}
        return result
    }
    
}
