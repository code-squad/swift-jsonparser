//
//  JSONParser.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    
    // 문자열을 JSONData로 파싱.
    static func parse(_ rawData: String) throws -> JSONData {
        var jsonData = JSONData()
        // 전체 데이터의 타입(object|array) 확인.
        if try isObjectType(rawData) {
            jsonData = try generateJSONData(from: rawData, ofType: JSONData.DataType.object)
        }else {
            jsonData = try generateJSONData(from: rawData, ofType: JSONData.DataType.array)
        }
        // 모든 JSONData 반환.
        return jsonData
    }
    
    // 가장 첫 괄호로 전체 데이터의 타입(object|array) 확인.
    private static func isObjectType(_ rawData: String) throws -> Bool {
        var index: String.Index = rawData.startIndex
        // 인덱스의 위치를 바꾸면서 공백은 건너뛰고 '{' 검색.
        if rawData[index] == " " {
            index = rawData.index(after: index)
        }else if rawData[index] == "{" {
            return true
        }
        return false
    }
    
    // blob 단위 JSONData 배열 반환.
    private static func generateJSONData(from data: String, ofType type: JSONData.DataType) throws -> JSONData {
        // 데이터를 저장할 JSONData 구조체.
        var jsonDataCollection = JSONData()
        // 타입에 따라 딕셔너리로 추출할지, 배열로 추출할지 결정.
        switch type {
        case .object:
            // 문자열 데이터를 딕셔너리로 변환.
            let objectData = try generateDictionary(from: data)
            // 데이터를 JSONData 구조체 내에 저장 - 딕셔너리를 파라미터로 받는 생성자 사용.
            jsonDataCollection.setData(objectData)
        case .array:
            // 문자열 데이터를 배열로 변환.
            let arrayData = try generateArray(from: data)
            // 데이터를 JSONData 구조체 내에 저장 - 배열을 파라미터로 받는 생성자 사용.
            jsonDataCollection.setData(arrayData)
        }
        // JSONData 반환.
        return jsonDataCollection
    }
    
    // 각 blob 내부 데이터들로 생성한 배열 반환.
    private static func generateArray(from data: String) throws -> JSONData.JSONArray {
        var stringValues: [String] = []
        // 가장 바깥쪽 괄호 제거.
        let rawDataWithoutBracket = try data.splitPattern(by: GrammarChecker.arrayDataWithoutBracket)
        // 배열 내부 데이터 단위로 자름.
        stringValues = try rawDataWithoutBracket[0].splitPattern(by: GrammarChecker.jsonValuePattern)
        // 각 문자열 데이터를 실 데이터로 변환.
        let resultValues = try stringValues.map { try makeRealElement(from: $0) }
        return resultValues
    }
    
    // 각 blob 내부 데이터들로 생성한 딕셔너리 반환.
    private static func generateDictionary(from data: String) throws -> JSONData.JSONObject {
        var dictionaries: JSONData.JSONObject = [:]
        // 가장 바깥쪽 괄호 제거.
        let rawDataWithoutBracket = try data.splitPattern(by: GrammarChecker.objectDataWithoutBracket)
        // 객체 내부 데이터 단위로 자름.
        let elements = try rawDataWithoutBracket[0].splitPattern(by: GrammarChecker.jsonObjectValueWithComma+"?")
        for element in elements {
            let key = try generateKey(from: element)
            let value = try generateValue(from: element)
            dictionaries.updateValue(value, forKey: key)
        }
        // 실제 값으로 변환된 딕셔너리 반환.
        return dictionaries
    }
    
    // 문자열에서 key 값 추출. 모든 key 값은 문자열이므로 타입 캐스팅 없음.
    private static func generateKey(from data: String) throws -> String {
        // 콜론(:) 기준 키 값 범위.
        let keyRange = data.startIndex..<data.index(of: ":")!
        // 키값 범위의 문자열. (따옴표\" 제거)
        let key = data[keyRange].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: ["\""])
        // 키 배열 반환.
        return key
    }
    
    // 문자열에서 value 값 추출 및 실제 value 타입으로 캐스팅.
    private static func generateValue(from data: String) throws -> Any {
        // 콜론(:) 기준 밸류값 범위.
        let valueRange = data.index(after: data.index(of: ":")!)..<data.endIndex
        // 밸류값 범위의 문자열. - 문자열, 부울, 숫자, 배열, 객체.
        let value = String(data[valueRange])
        // 실제 값으로 변환하여 리턴.
        let realData = try makeRealElement(from: value)
        return realData
    }
    
    // 개별 문자열 데이터를 실 데이터로 변환.
    private static func makeRealElement(from value: String) throws -> Any {
        if value.contains("[") {
            // 배열 형태의 데이터 형변환.
            return try generateArray(from: value)
        }else if value.contains("{") {
            // 객체 형태의 데이터 형변환.
            return try generateDictionary(from: value)
        }else {
            // 기본형 데이터 형변환.
            guard let convertedValue = try generateBasicData(from: value) else { throw GrammarChecker.JsonError.dataOfNil }
            return convertedValue
        }
    }
    
    // 기본형 문자열 데이터를 실제 값으로 변환.
    private static func generateBasicData(from data: String) throws -> Any? {
        var value: Any?
        // 데이터 전처리 (콤마 및 공백 제거)
        let trimmedData = data.trimmingCharacters(in: [","]).trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedData.contains("\"") {
            // 콤마, 따옴표 양쪽공백(데이터 내 공백 유지), 따옴표 제거
            value = trimmedData.trimmingCharacters(in: ["\""])
        }else if let numberElement = JSONData.JSONNumber(trimmedData) {
            value = numberElement
        }else if let boolElement = JSONData.JSONBool(trimmedData) {
            value = boolElement
        }
        return value
    }
    
}
