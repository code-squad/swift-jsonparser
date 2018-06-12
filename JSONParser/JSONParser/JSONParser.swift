//
//  JSONParser.swift
//  JSONParser
//
//  Created by Yoda Codd on 2018. 5. 21..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // JSON 에서 데이터를 나누는 단위
    static let separater : Character = ","
    // JSON 에서 문자열을 감싸는 단위
    static let letterWrapper : Character = "\""
    // JSON 에서 Bool 타입을 표현하는 문자열의 배열
    static let booleanType = ["false", "true"]
    // JSON 배열의 처음 문자
    static let startOfArrayOfJSON : Character  = "["
    // JSON 배열의 마지막 문자
    static let endOfArrayOfJSON : Character  = "]"
    // JSON 오브젝트의 처음 문자
    static let startOfObjectOfJSON : Character  = "{"
    // JSON 오브젝트의 마지막 문자
    static let endOfObjectOfJSON : Character  = "}"
    // JSON 오브젝트에서 키와 값을 나누는 문자
    static let separaterForObject : Character = ":"
    
    // JSON 데이터로 들어갈 수 있는 종류
    // 인트형 타입
    static let typeInt : Int.Type = Int.self
    // 문자형 타입
    static let typeString : String.Type = String.self
    // Bool 타입
    static let typeBool : Bool.Type = Bool.self
    // 객체형 타입
    static private let emptyObject : [String:Any] = [:]
    static let typeObject = type(of: emptyObject)
    
    
    /// 문자열을 받아서 JSON 타입으로 리턴
     func transformLetterToDataOfJSONObject(letter:String) -> Any? {
        // 인트형이 가능한지 체크. 변환가능하면 변환해서 추가
        if GrammarChecker.checkIntType(letter: letter) {
            return Int(letter)
        }
            // Bool 타입인지 체크. 가능하면 변환해서 추가
        else if GrammarChecker.checkBoolType(letter: letter){
            return Bool(letter)!
        }
            // " 로 둘러쌓인 문자열인지 체크 후 추가
        else if GrammarChecker.checkStringType(letter: letter){
            return (letter)
        }
            // 어느것도 매칭되지 않는다면 닐 리턴
        else {
            return nil
        }
    }
    
    /// 키:벨류 로 붙어있는 문자열을 받아서 키부분 리턴
    private func extractKeyFromObjectLetter(letter: String) -> String {
        // : 을 기준으로 문자열을 자른다
        let separatedLetter = letter.split(separator: JSONParser.separaterForObject)
        // 키 부분의 공백을 지워주고 변수화 한다
        let key = separatedLetter[0].trimmingCharacters(in: .whitespaces)
        // " 을 제외한 나머지 문자열을 내보낸다
        return key.replacingOccurrences(of: "\"", with: "")
    }
    
    /// 키:벨류 로 붙어있는 문자열을 받아서 벨류 부분 리턴
    private func extractValueFromObjectLetter(letter: String) -> Any? {
        // : 을 기준으로 문자열을 자른다
        let separatedLetter = letter.split(separator: JSONParser.separaterForObject)
        // 키 부분의 공백을 지워주고 변수화 한다
        let value = separatedLetter[1].trimmingCharacters(in: .whitespaces)
        // " 을 제외한 나머지 문자열을 내보낸다.
        return transformLetterToDataOfJSONObject(letter: value)
    }
    
    /// , 로 나눠진 객체형 배열을 객체형 으로 만들어서 리턴
    private func combineSeparatedJSONObeject(letters: [String]) -> [String:Any]? {
        // 입력값이 JSON 객체형 데이터 인지 체크
        guard GrammarChecker.checkObjectValueTypes(types: letters) == true else {
            return nil
        }
        // 결과용 JSON 객체형을 선언한다
        var result : [String:Any] = [:]
        // 각 키와 밸류를 반복문에 넣어서 JSON 객체형으로 리턴
        for object in letters {
            // 키:벨류 형태의 문자열을 받아서 결과 객체에 추가한다
            let key = extractKeyFromObjectLetter(letter: String(object))
            guard let value = extractValueFromObjectLetter(letter: String(object)) else {
                return nil
            }
            result[key] = value
        }
        // 결과를 리턴한다
        return result
    }
    
    /// {} 로 둘러 쌓이지 않은 문자열을 받아서 객체형으로 리턴
    private func transformLetterToJSONObjectWithoutWrapper(letter: String) -> [String:Any]? {
        // 뒤에서 함수에 사용할 문자형 배열 선언
        var separatedByComma : [String] = []
        // , 를 기준으로 나눠서 배열로 만든다
        let separatedSubSequencesByComma = letter.split(separator: JSONParser.separater)
        // , 기준으로 나눠진 배열을 반복문에 넣는다
        for subSequence in separatedSubSequencesByComma {
            // 나눠진 데이터의 앞뒤 공백을 제거한다
            let data = String(subSequence).trimmingCharacters(in: .whitespaces)
            // 앞뒤 공백 제거된 데이터를 결과에 추가한다
            separatedByComma.append(data)
        }
        // 각 키와 밸류를 반복문에 넣어서 JSON 타입이 맞는지 체크, 결과를 리턴한다
        return combineSeparatedJSONObeject(letters: separatedByComma)
    }
    
    /// {} 로 둘러쌓인 문자열을 받아서 JSON 객체형으로 리턴
    private func transformLetterToJSONObjectWithWrapper(letter: String) -> [String:Any]? {
        // 앞의 함수에서 체크된 대로 {} 를 제거
        let withoutWrapper = String(letter[letter.index(letter.startIndex, offsetBy: 1)..<letter.index(letter.endIndex, offsetBy: -1)])
        // {} 가 없는 객체형 체크 함수를 리턴한다
        return transformLetterToJSONObjectWithoutWrapper(letter: withoutWrapper)
    }
    
    /// 문자열을 받아서 JSON 타입으로 리턴
    private func transformLetterToDataOfJSONArray(letter:String) -> Any? {
        // {} 로 둘러쌓인 객체형인지 체크 후 추가
        if GrammarChecker.checkObjectType(letter: letter){
            return transformLetterToJSONObjectWithWrapper(letter: letter)
        }
        // 객체형을 제외한 데이터 타입 리턴함수 사용
        guard let transformedData = transformLetterToDataOfJSONObject(letter: letter) else {
            // {} 이 외에 어느것도 매칭되지 않는다면 닐 리턴
            return nil
        }
        // 결롸를 리턴
        return transformedData
    }    
    
    /// 문자열 배열을 받아서 JSON 배열로 생성. 변환 불가능한 값이 있으면 닐 리턴
    private func transformLettersToJSONArray(letters:[String]) -> [Any]? {
        // 결과 출력용 배열 선언
        var result :[Any] = []
        // 배열을 반복분에 넣는다
        for letter in letters {
            // JSON 에 추가 가능한지 체크. 변환가능하면 변환해서 추가
            guard let transformedValue = transformLetterToDataOfJSONArray(letter: letter) else {
                return nil
            }
            result.append(transformedValue)
        }
        // 결과 리턴
        return result
    }
    
    /// 문자열을 받아서 JSON 객체로 생성. 변환 불가능한 값이 있으면 닐 리턴
    func transform(letters:[String]) -> JSONCount? {
        // 첫번째 배열을 받아서 어떤 형태인지 파악한다
        let typeOfJSON = letters[0]
        // 배열분류자 를 제외한 나머지 배열을 입력받는다
        var dataOfJSON = letters
        dataOfJSON.remove(at: 0)
        // 만약 배열형테면
        if typeOfJSON == "[" {
            // 문자열 배열을 JSON 배열 형태로 만든다
            guard let transformedLetters =  transformLettersToJSONArray(letters: dataOfJSON) else {
                return nil
            }
            // 결과를 리턴한다
            return JSONArray(dataSetOfJSON: transformedLetters)
        }
        // 객체 형태면
        else if typeOfJSON == "{" {
            // 문자열 배열을 JSON 객체 형태로 만든다
            guard let transformedLetters =  combineSeparatedJSONObeject(letters: dataOfJSON) else {
                return nil
            }
            // 결과를 리턴한다
            return JSONObject(dataSetOfJSON: transformedLetters)
        }
        // 배열, 객체 형태도 아니면 닐 리턴
        else { return nil }        
    }
}

