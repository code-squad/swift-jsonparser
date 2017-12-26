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
    // 객체타입 생성
    static func makeJsonObject(_ inputValue: String) -> [String:Any] {
        var jsonObject = [String:Any]()
         let elementsOfObject = Analyzer.getElementsOfObject(from: inputValue)
        _ = elementsOfObject.forEach {
            let keyValue = $0.split(separator: ":").map {$0.trimmingCharacters(in: .whitespaces)}
            let key : String = String(describing: keyValue.first ?? "").replacingOccurrences(of: "\"", with: "")
            let value : Any = generateValueInObject(stringNotyetValue: String(describing: keyValue.last ?? ""))
            jsonObject.updateValue(value, forKey: key)
        }
        return jsonObject
    }
    
    //  입력된 스트링값을 각 문법규칙에 맞게 배열로 변환
    static func makeJsonArray(with target: String) -> Array<String> {
        var elementsFromArray : Array<String> = []
        var initialValue = target
        initialValue.removeFirst()
        initialValue.removeLast()
        if initialValue.contains("{") {
            elementsFromArray.append(getObjectMatches(from: initialValue))
            initialValue = initialValue.replacingOccurrences(of: getObjectMatches(from: initialValue), with: "")
        }
        if initialValue.contains("[") {
            elementsFromArray.append(getArrayMatches(from: initialValue))
            initialValue = initialValue.replacingOccurrences(of: getArrayMatches(from: initialValue), with: "")
        }
        elementsFromArray.append(contentsOf: getElementsOfValue(from: initialValue))
        return elementsFromArray
    }
    
    
    //  객체 내의 벨류생성
     private static func generateValueInObject(stringNotyetValue: String) -> Any {
        if stringNotyetValue.hasPrefix("[") && stringNotyetValue.hasSuffix("]") { return stringNotyetValue }
        else if stringNotyetValue.starts(with: "\"") { return stringNotyetValue.replacingOccurrences(of: "\"", with: "")}
        else if let interger = Int(stringNotyetValue) { return interger }
        else if let boolean = Bool(stringNotyetValue) { return boolean }
        else { return ""}
    }
    
    // Mark : 배열 및 객체 각각의 세부 값 추출 (스트링으로 추출됨)
    //  배열 내부의 객체 추출
     private static func getObjectMatches(from target: String) -> String {
        let leftBrace = target.index(of: "{") ?? target.endIndex
        let rightBrace = target.index(of: "}") ?? target.endIndex
        return String(target[leftBrace...rightBrace])
    }
    
    //  배열 내부의 배열 추출
     private static func getArrayMatches(from target: String) -> String {
        let leftSquareBracket = target.index(of: "[") ?? target.endIndex
        let rightSquareBracket = target.index(of: "]") ?? target.endIndex
        return String(target[leftSquareBracket...rightSquareBracket])
    }
    
    //  배열내부의 배열,객체 제외한 값 추출
     private static func getElementsOfValue(from target: String) -> Array<String> {
        return getElementsOfMatchedWIthJsonGrammer(inputValue: target, pattern: JsonGrammerRule.ofValue)
    }
    
    //  객체 내부에서 카운팅할 값들 추출
     private static func getElementsOfObject(from target: String) -> Array<String> {
        return getElementsOfMatchedWIthJsonGrammer(inputValue: target, pattern: JsonGrammerRule.ofNestedDictionary)
    }
    
    // Mark : 문법과 매칭할 NS함수
     private static func getElementsOfMatchedWIthJsonGrammer(inputValue: String, pattern: String) -> Array<String> {
        let regularExpression = try! NSRegularExpression(pattern: pattern)
        let matchedValue = regularExpression.matches(in: inputValue, range: NSRange(location:0, length:inputValue.count))
        let result = matchedValue.map {String(inputValue[Range($0.range, in: inputValue)!])}
        return result
    }
    
}
