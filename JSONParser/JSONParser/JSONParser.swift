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
        var rawDataWithoutBracket: [String] = []
        var jsonData = JSONData()
        // 전체 데이터의 타입(object|array) 확인.
        if try isObjectType(rawData) {
            // 가장 바깥쪽 괄호를 제거한 전체데이터. (따라서 1개밖에 없음.)
            rawDataWithoutBracket = try rawData.splitPattern(by: GrammarChecker.objectDataWithoutBracket)
            // JSONData 객체 생성.
            jsonData = try generateJSONData(from: rawDataWithoutBracket[0], ofType: JSONData.DataType.object)
        }else {
            rawDataWithoutBracket = try rawData.splitPattern(by: GrammarChecker.arrayDataWithoutBracket)
            jsonData = try generateJSONData(from: rawDataWithoutBracket[0], ofType: JSONData.DataType.array)
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
    private static func generateArray(from data: String) throws -> [Any] {
        var stringValues: [String] = []
        // array 내부 데이터로 들어갈 수 있는 밸류패턴으로 자름. (문자열, 부울, 숫자, 배열, 객체 패턴.)
        stringValues = try data.splitPattern(by: GrammarChecker.jsonValuePattern)
        // 각 문자열 데이터를 실 데이터로 변환.
        let resultValues: [Any] = try stringValues.map { try makeRealElement(from: $0) }
        return resultValues
    }
    
    // 각 blob 내부 데이터들로 생성한 딕셔너리 반환.
    private static func generateDictionary(from data: String) throws -> [String:Any] {
        var dictionaries: [String:Any] = [:]
        var elements: [String] = []
        elements = try data.splitPattern(by: GrammarChecker.jsonObjectValueWithComma+"?")
        for element in elements {
            let key = try generateKey(from: element)
            let value = try generateValue(from: element)
            dictionaries.updateValue(value, forKey: key)
        }
        // 실제 값으로 변환된 [String:Any] 반환.
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
        return try makeRealElement(from: value)
    }
    
    // 개별 문자열 데이터를 실 데이터로 변환.
    private static func makeRealElement(from value: String) throws -> Any {
        if value.contains("[") {
            // 배열 형태의 데이터 형변환.
            return try generateNestedBlobData(from: value, of: .array)
        }else if value.contains("{") {
            // 객체 형태의 데이터 형변환.
            return try generateNestedBlobData(from: value, of: .object)
        }else {
            // 기본형 데이터 형변환.
            guard let convertedValue = try generateBasicData(from: value) else { throw GrammarChecker.JsonError.dataOfNil }
            return convertedValue
        }
    }
    
    // 객체 또는 배열 형태의 데이터 형변환.
    private static func generateNestedBlobData(from data: String, of type: JSONData.DataType) throws -> JSONData.JSONArray {
        var arrayValue: JSONData.JSONArray = []
        // data = 내부배열. elements = 내부배열 내의 각 문자열 데이터.(정규표현식을 쓰려고 했으나 오류남)
        var elements: [String] = []
        let trimmedData = data.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [","])
        switch type {
        case .array:
            // 내부 배열 데이터를 기본형 데이터 단위로 분리.
            elements = trimmedData.trimmingCharacters(in: ["[","]"]).split(separator: ",").map(String.init)
            for element in elements {
                // 내부 배열 내의 각 기본형 문자열 데이터를 실제 데이터로 변환.
                guard let convertedValue = try generateBasicData(from: element) else { break }
                arrayValue.append(convertedValue)
            }
        case .object:
            var convertedValue: [String:Any] = [:]
            // 내부 객체 데이터를 기본형 데이터 단위로 분리.
            elements = trimmedData.trimmingCharacters(in: ["{","}"]).split(separator: ",").map(String.init)
            for element in elements {
                // 내부 객체 내의 각 기본형 문자열 데이터를 실제 데이터로 변환.
                convertedValue = try generateDictionary(from: element)
                // 딕셔너리 내부 값만 빼서 붙임.
                arrayValue.append(convertedValue.popFirst()!)
            }
        }
        return arrayValue
    }
    
    // 기본형 문자열 데이터를 실제 값으로 변환.
    private static func generateBasicData(from data: String) throws -> Any? {
        var value: Any?
        // 데이터 전처리 (콤마 및 공백 제거)
        let trimmedData = data.trimmingCharacters(in: [","]).trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedData.contains("\"") {
            // 콤마, 따옴표 양쪽공백(데이터 내 공백 유지), 따옴표 제거
            value = trimmedData.trimmingCharacters(in: ["\""])
        }else if let numberElement = JSONData.Number(trimmedData) {
            value = numberElement
        }else if let boolElement = Bool(trimmedData) {
            value = boolElement
        }
        return value
    }
    
}
