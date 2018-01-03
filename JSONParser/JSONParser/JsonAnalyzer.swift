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
    
    // 분석된 타입 인스턴스를 반환
    static func makeAnalyzedTypeInstance (_ inputValue: String) -> JsonDataCommon & JSONType{
        return inputValue.first == "{" ? getJsonObject(inputValue) : getJsonArray(inputValue)
    }
    
    // 입력된 스트링값을 객체 문법규칙에 맞게 변환
    private static func getJsonObject(_ inputValue: String) -> [String:JSONType] {
        var jsonObject = [String:JSONType]()
        let elementsOfObject = Analyzer.getElementsOfObject(from: inputValue)
        elementsOfObject.forEach {
            let keyValue = $0.split(separator: ":").map {$0.trimmingCharacters(in: .whitespaces)}
            let key : String = String(describing: keyValue.first ?? "").replacingOccurrences(of: "\"", with: "")
            let value : JSONType = generateValueInObject(stringNotyetValue: String(describing: keyValue.last ?? ""))
            jsonObject.updateValue(value, forKey: key)
        }
        return jsonObject
    }
    
    //  입력된 스트링값을 각 배열규칙에 맞게 변환
    private static func getJsonArray(_ inputValue: String) -> Array<String> {
        var elementsFromArray : Array<String> = []
        var initialValue = inputValue
        initialValue = removeFirstAndLastCharacter(initialValue)
        elementsFromArray.append(contentsOf: getObjectOfArray(from: initialValue))
        initialValue = removeMatchedObjectfromString(from: initialValue)
        elementsFromArray.append(contentsOf: getArrayOfArray(from: initialValue))
        initialValue = removeMatchedArrayfromString(from: initialValue)
        elementsFromArray.append(contentsOf: getValueFromArray(from: initialValue))
        return elementsFromArray
    }
    
    //  객체 내의 벨류생성
    private static func generateValueInObject(stringNotyetValue: String) -> JSONType {
        if stringNotyetValue.hasPrefix("[") && stringNotyetValue.hasSuffix("]") { return stringNotyetValue }
        else if stringNotyetValue.starts(with: "\"") { return stringNotyetValue.replacingOccurrences(of: "\"", with: "")}
        else if let interger = Int(stringNotyetValue) { return interger }
        else if let boolean = Bool(stringNotyetValue) { return boolean }
        else { return ""}
    }
    
    // Mark : 배열 및 객체 각각의 세부 값 추출 (어레이 스트링으로 추출됨)
    
    //  배열내부의 객체 추출
    private static func getObjectOfArray(from input: String) -> Array<String> {
        return getElementsOfMatchedWIthJsonGrammer(inputValue: input, pattern: JsonGrammerRule.ofObject)
    }
    
    //  배열내부의 배열 추출
    private static func getArrayOfArray(from input: String) -> Array<String> {
        return getElementsOfMatchedWIthJsonGrammer(inputValue: input, pattern: JsonGrammerRule.ofArray)
    }
    
    //  배열내부의 배열,객체 제외한 값 추출
    private static func getValueFromArray(from input: String) -> Array<String> {
        return getElementsOfMatchedWIthJsonGrammer(inputValue: input, pattern: JsonGrammerRule.ofValue)
    }
    
    //  객체 내부에서 카운팅할 값들 추출
    private static func getElementsOfObject(from input: String) -> Array<String> {
        return getElementsOfMatchedWIthJsonGrammer(inputValue: input, pattern: JsonGrammerRule.ofNestedDictionary)
    }
    
    // 문법과 매칭하여 값을 추출할 NS함수
    private static func getElementsOfMatchedWIthJsonGrammer(inputValue: String, pattern: String) -> Array<String> {
        let regularExpression = try! NSRegularExpression(pattern: pattern)
        let matchedValue = regularExpression.matches(in: inputValue, range: NSRange(location:0, length:inputValue.count))
        let result = matchedValue.map {String(inputValue[Range($0.range, in: inputValue)!])}
        return result
    }
    
    // Mark : 매칭된 값 삭제
    //  이미 매칭된 객체를 삭제
    private static func removeMatchedObjectfromString (from input: String) -> String {
        return removeAlreadyMatchedPattern(from: input, pattern: JsonGrammerRule.ofObject)
    }
    
    //  이미 매칭된 배열을 삭제
    private static func removeMatchedArrayfromString (from input: String) -> String {
        return removeAlreadyMatchedPattern(from: input, pattern: JsonGrammerRule.ofArray)
    }
    
    // 문법과 매칭된 값을 삭제하는 NS함수
    private static func removeAlreadyMatchedPattern(from input: String, pattern: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        return regex.stringByReplacingMatches(
            in: input,
            range: NSRange(location: 0, length: input.count),
            withTemplate: ""
        )
    }
    
    // Mark : 문자열의 처음과 끝을 제거하는 함수
    private static func removeFirstAndLastCharacter (_ input: String) -> String {
        var input = input
        input.removeFirst()
        input.removeLast()
        return input
    }
    
}
