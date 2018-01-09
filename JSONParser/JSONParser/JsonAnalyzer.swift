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
    static func makeAnalyzedTypeInstance (_ inputValue: String) -> JSONDataCommon & JSONType{
        return inputValue.first == Character(ElementOfString.leftBrace.rawValue) ? getJsonObject(inputValue) : getJSONArray(elements: getJsonElementFromArray(inputValue))
    }
    
    // 입력된 스트링값을 객체 문법규칙에 맞게 변환
    private static func getJsonObject (_ inputValue: String) -> [String:JSONType] {
        var jsonObject = [String:JSONType]()
        let elementsOfObject = Analyzer.getJsonElementsFromObject(from: inputValue)
        elementsOfObject.forEach {
            let keyValue = $0.split(separator: Character(ElementOfString.colon.rawValue)).map {$0.trimmingCharacters(in: .whitespaces)}
            let key : String = String(describing: keyValue.first ?? ElementOfString.emptyString.rawValue).replacingOccurrences(of: ElementOfString.doubleQuotationMarks.rawValue, with: ElementOfString.emptyString.rawValue)
            let value : JSONType = getEachValue(stringNotyetValue: String(describing: keyValue.last ?? ElementOfString.emptyString.rawValue))
            jsonObject.updateValue(value, forKey: key)
        }
        return jsonObject
    }
    
    
    //  입력된 스트링값을 각 배열규칙에 맞게 변환
    private static func getJsonElementFromArray(_ inputValue: String) -> Array<String> {
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
    
    private static func getJSONArray(elements: Array<String>) -> [JSONType] {
        var jsonArray = [JSONType]()
        for element in elements {
            jsonArray.append(getEachValue(stringNotyetValue: element))
        }
        return jsonArray
    }
    
    //  객체 내의 벨류생성
    private static func getEachValue(stringNotyetValue: String) -> JSONType {
        if stringNotyetValue.hasPrefix(ElementOfString.leftSquareBracket.rawValue) { return getJSONArray(elements: getJsonElementFromArray(stringNotyetValue)) }
        else if stringNotyetValue.hasPrefix(ElementOfString.leftBrace.rawValue) { return getJsonObject(stringNotyetValue)}
        else if stringNotyetValue.starts(with: ElementOfString.doubleQuotationMarks.rawValue) { return stringNotyetValue.replacingOccurrences(of: ElementOfString.doubleQuotationMarks.rawValue, with: ElementOfString.emptyString.rawValue)}
        else if let interger = Int(stringNotyetValue) { return interger }
        else if let boolean = Bool(stringNotyetValue) { return boolean }
        else { return ElementOfString.emptyString.rawValue}
    }
    
    // Mark : 배열 및 객체 각각의 세부 값 추출 (어레이 스트링으로 추출됨)
    
    //  배열내부의 객체 추출
    private static func getObjectOfArray(from input: String) -> Array<String> {
        return getElementsOfMatchedWIthJSONGrammer(inputValue: input, pattern: JSONGrammerRule.ofObject)
    }
    
    //  배열내부의 배열 추출
    private static func getArrayOfArray(from input: String) -> Array<String> {
        return getElementsOfMatchedWIthJSONGrammer(inputValue: input, pattern: JSONGrammerRule.ofArray)
    }
    
    //  배열내부의 배열,객체 제외한 값 추출
    private static func getValueFromArray(from input: String) -> Array<String> {
        return getElementsOfMatchedWIthJSONGrammer(inputValue: input, pattern: JSONGrammerRule.ofValue)
    }
    
    //  객체 내부에서 카운팅할 값들 추출
    private static func getJsonElementsFromObject(from input: String) -> Array<String> {
        return getElementsOfMatchedWIthJSONGrammer(inputValue: input, pattern: JSONGrammerRule.ofNestedDictionary)
    }
    
    // 문법과 매칭하여 값을 추출할 NS함수
    private static func getElementsOfMatchedWIthJSONGrammer(inputValue: String, pattern: String) -> Array<String> {
        let regularExpression = try! NSRegularExpression(pattern: pattern)
        let matchedValue = regularExpression.matches(in: inputValue, range: NSRange(location:0, length:inputValue.count))
        let result = matchedValue.map {String(inputValue[Range($0.range, in: inputValue)!])}
        return result
    }
    
    // Mark : 매칭된 값 삭제
    //  이미 매칭된 객체를 삭제
    private static func removeMatchedObjectfromString (from input: String) -> String {
        return removeAlreadyMatchedPattern(from: input, pattern: JSONGrammerRule.ofObject)
    }
    
    //  이미 매칭된 배열을 삭제
    private static func removeMatchedArrayfromString (from input: String) -> String {
        return removeAlreadyMatchedPattern(from: input, pattern: JSONGrammerRule.ofArray)
    }
    
    // 문법과 매칭된 값을 삭제하는 NS함수
    private static func removeAlreadyMatchedPattern(from input: String, pattern: String) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        return regex.stringByReplacingMatches(
            in: input,
            range: NSRange(location: 0, length: input.count),
            withTemplate: ElementOfString.emptyString.rawValue
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

// Mark : Argument카운트에따라 메인에서 다르게 호출됨
extension Analyzer {
    static func makeConsoleAnalyzedResult  (unanalyzedValue: String) throws -> JSONDataCommon & JSONType {
        let validString = try GrammerChecker.makeValidString(values: unanalyzedValue)
        let analyzedValue = self.makeAnalyzedTypeInstance(validString)
        return analyzedValue
    }
    
    static func makeFileAnalyzedResult  (unanalyzedValue: String) throws -> JSONDataCommon & JSONType {
        let validString = try GrammerChecker.makeValidString(values: unanalyzedValue)
        let analyzedValue = self.makeAnalyzedTypeInstance(validString)
        return analyzedValue
    }
}
