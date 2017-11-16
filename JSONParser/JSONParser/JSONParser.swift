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
            // 가장 바깥쪽 괄호를 제거한 데이터.
            rawDataWithoutBracket = try rawData.splitPattern(by: GrammarChecker.objectDataWithoutBracket)
            // JSONData 객체 생성.
            jsonData = try generateJSONData(from: rawDataWithoutBracket, ofType: JSONData.DataType.object)
        }else {
            rawDataWithoutBracket = try rawData.splitPattern(by: GrammarChecker.arrayDataWithoutBracket)
            jsonData = try generateJSONData(from: rawDataWithoutBracket, ofType: JSONData.DataType.array)
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
    private static func generateJSONData(from blobs: [String], ofType type: JSONData.DataType) throws -> JSONData {
        // 데이터를 저장할 JSONData 구조체.
        var jsonDataCollection = JSONData()
        // blobs = array 또는 object 문자열 배열들.
        // blob = 각 데이터들의 문자열 배열. 콤마 기준으로 나눔.
        for blob in blobs {
            // 타입에 따라 딕셔너리로 추출할지, 배열로 추출할지 결정.
            switch type {
            case .object:
                // 문자열 데이터를 딕셔너리로 변환.
                let objectData = try convertToDictionary(from: blob)
                // 데이터를 JSONData 구조체 내에 저장 - 딕셔너리를 파라미터로 받는 생성자 사용.
                jsonDataCollection.setData(objectData)
            case .array:
                // 문자열 데이터를 배열로 변환.
                let arrayData = try convertToArray(from: blob)
                // 데이터를 JSONData 구조체 내에 저장 - 배열을 파라미터로 받는 생성자 사용.
                jsonDataCollection.setData(arrayData)
            }
        }
        // JSONData 반환.
        return jsonDataCollection
    }
    
    // 각 blob 내부 데이터들로 생성한 딕셔너리 반환.
    private static func convertToDictionary(from data: String) throws -> [String:Any] {
        var dictionaries: [String:Any] = [:]
        // 키 생성.
        let keys = try generateKey(from: data)
        // 밸류 생성.
        let values = try generateValue(from: data, type: .object)
        // 각 키값과 밸류값을 딕셔너리에 붙임.
        for i in 0..<keys.count {
            dictionaries.updateValue(values[i], forKey: keys[i])
        }
        // 실제 값으로 변환된 [String:Any] 반환.
        return dictionaries
    }
    
    // 각 blob 내부 데이터들로 생성한 배열 반환.
    private static func convertToArray(from data: String) throws -> [Any] {
        var arrays: [Any] = []
        // 문자열을 배열로 변환하여 반환.
        arrays = try generateValue(from: data, type: .array)
        return arrays
    }
    
    // 문자열에서 key 값 추출. 모든 key 값은 문자열이므로 타입 캐스팅 없음.
    private static func generateKey(from data: String) throws -> [String] {
        var keys: [String] = []
        // 콤마(,) 기준으로 모든 데이터 분류 ( 키: 값, 키: 값, ... )
        let elements = data.split(separator: ",").map { String($0) }
        // 모든 문자열 데이터들에서
        for element in elements {
            // 콜론(:) 기준 키 값 범위.
            let keyRange = element.startIndex...element.index(before: element.index(of: ":")!)
            // 키값 범위의 문자열. (따옴표\" 제거)
            let key = element[keyRange].trimmingCharacters(in: ["\""])
            // 키 배열에 추가.
            keys.append(key)
        }
        // 키 배열 반환.
        return keys
    }
    
    // 문자열에서 value 값 추출 및 실제 value 타입으로 캐스팅.
    private static func generateValue(from data: String, type: JSONData.DataType) throws -> [Any] {
        var stringValues: [String] = []
        // object 내 데이터인지, array 내 데이터인지에 따라 다르게 처리.
        switch type {
        case .object:
            // 콤마(,) 기준으로 모든 데이터 분류 ( 키: 값, 키: 값, ... )
            let elements = data.split(separator: ",").map { String($0) }
            // 모든 문자열 데이터들에서
            for element in elements {
                // 콜론(:) 기준 밸류값 범위.
                let valueRange = element.index(after: element.index(of: ":")!)..<element.endIndex
                // 밸류값 범위의 문자열. - 문자열, 부울, 숫자, 배열, 객체.
                let value = String(element[valueRange])
                // 밸류 배열에 추가.
                stringValues.append(value)
            }
        case .array:
            // array 내부 데이터로 들어갈 수 있는 밸류값. - 문자열, 부울, 숫자, 배열, 객체.
            stringValues = try data.splitPattern(by: GrammarChecker.arrayValuePattern)
        }
        // 문자열 값을 실제 값으로 변환.
        let realValues = try makeRealData(from: stringValues)
        // 실제 값으로 변환된 [Any] 반환.
        return realValues
    }
    
    // 모든 문자열 데이터를 실제 값 데이터로 변환.
    private static func makeRealData(from stringValues: [String]) throws -> [Any] {
        var resultValues: [Any] = []
        for value in stringValues {
            if value.contains("[") {
                // 객체 형태의 데이터 형변환.
                let convertedArray = try convertStringToAnyArray(from: value, ofType: .array)
                resultValues.append(convertedArray)
            }else if value.contains("{") {
                // 배열 형태의 데이터 형변환.
                let convertedObject = try convertStringToAnyArray(from: value, ofType: .object)
                resultValues.append(convertedObject)
            }else {
                // 기본형 데이터 형변환.
                guard let convertedValue = try convertStringToAny(from: value) else { break }
                resultValues.append(convertedValue)
            }
        }
        return resultValues
    }
    
    // 객체 또는 배열 형태의 데이터 형변환.
    private static func convertStringToAnyArray(from data: String, ofType type: JSONData.DataType) throws -> [Any] {
        var arrayValue: [Any] = []
        // data = 내부배열. elements = 내부배열 내의 각 문자열 데이터.(정규표현식을 쓰려고 했으나 오류남)
        var elements: [String] = []
        switch type {
        case .array:
            // 내부 배열 데이터를 기본형 데이터 단위로 분리.
            elements = data.trimmingCharacters(in: ["[","]"]).split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            for element in elements {
                // 내부 배열 내의 각 기본형 문자열 데이터를 실제 데이터로 변환.
                guard let convertedValue = try convertStringToAny(from: element) else { break }
                arrayValue.append(convertedValue)
            }
        case .object:
            var convertedValue: [String:Any] = [:]
            // 내부 객체 데이터를 기본형 데이터 단위로 분리.
            elements = data.trimmingCharacters(in: ["{","}"]).split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            for element in elements {
                // 내부 객체 내의 각 기본형 문자열 데이터를 실제 데이터로 변환.
                convertedValue = try convertToDictionary(from: element)
                // 딕셔너리 내부 값만 빼서 붙임.
                arrayValue.append(convertedValue.popFirst()!)
            }
        }
        return arrayValue
    }
    
    // 기본형 문자열 데이터를 실제 값으로 변환.
    private static func convertStringToAny(from data: String) throws -> Any? {
        var value: Any?
        if data.contains("\"") {
            value = data.trimmingCharacters(in: ["\""])
        }else if let numberElement = JSONData.Number(data) {
            value = numberElement
        }else if let boolElement = Bool(data) {
            value = boolElement
        }
        return value
    }
    
}
