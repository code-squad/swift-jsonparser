//
//  JSONParser.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    
    // 문자열을 JSONData로 파싱하여 배열로 반환.
    static func parse(_ rawData: String) throws -> JSONData {
        var rawDataWithoutBracket: [String] = []
        var jsonData = JSONData()
        // 각 데이터 추출한 문자열 데이터. (object, array는 하나로 묶음. 1뎁스까지만 추출.)
        if try isObjectType(rawData) {
            rawDataWithoutBracket = try rawData.splitPattern(by: GrammarChecker.JSONObjectPattern)
            // JSONData 객체 생성. (Object Type, Array Type 객체로 분리.)
            jsonData = try generateJSONData(from: rawDataWithoutBracket, ofType: JSONData.DataType.object)
        }else {
            rawDataWithoutBracket = try rawData.splitPattern(by: GrammarChecker.JSONArrayPattern)
            jsonData = try generateJSONData(from: rawDataWithoutBracket, ofType: JSONData.DataType.array)
        }
        // 모든 JSONData 배열 반환.
        return jsonData
    }
    
    private static func isObjectType(_ rawData: String) throws -> Bool {
        guard rawData.first == "{" else { return false }
        return true
    }
    
    // blob 단위 JSONData 배열 반환.
    private static func generateJSONData(from blobs: [String], ofType type: JSONData.DataType) throws -> JSONData {
        var jsonDataCollection = JSONData()
        // blobs = array 또는 object 문자열 배열들.
        // blob = 각 데이터들의 문자열 배열. 콤마 기준으로 나눔.
        for blob in blobs {
            // 타입에 따라 딕셔너리 형태로 추출할지, 배열 형태로 추출할지 결정.
            switch type {
            case .object: // 딕셔너리로 변환한 후, JSONData 객체 생성하여 추가.
                let objectData = try convertToDictionary(from: blob)
                jsonDataCollection.setData(objectData)
            case .array:
                let arrayData = try convertToArray(from: blob)
                jsonDataCollection.setData(arrayData)
            }
        }
        return jsonDataCollection
    }
    
    // 각 blob 내부 데이터들로 딕셔너리 생성하여 반환.
    private static func convertToDictionary(from data: String) throws -> [String:Any] {
        var dictionaries: [String:Any] = [:]
        let keys = try generateKey(from: data)
        let values = try generateValue(from: data, type: .object)
        for i in 0..<keys.count {
            dictionaries.updateValue(values[i], forKey: keys[i])
        }
        return dictionaries
    }
    
    // 각 blob 내부 데이터들로 배열 생성하여 반환.
    private static func convertToArray(from data: String) throws -> [Any] {
        var arrays: [Any] = []
        arrays = try generateValue(from: data, type: .array)
        return arrays
    }
    
    // 문자열에서 key 값 추출.
    private static func generateKey(from data: String) throws -> [String] {
        var keys: [String] = []
        // 키 패턴만 추출. 따옴표 제거.
        let elements = data.split(separator: ",").map { String($0) }
        for element in elements {
            let keyRange = element.startIndex...element.index(before: element.index(of: ":")!)
            let key = element[keyRange].trimmingCharacters(in: [" ", "\""])
            keys.append(key)
        }
        return keys
    }
    
    // 문자열에서 value 값 추출 및 실제 value 타입으로 캐스팅.
    private static func generateValue(from data: String, type: JSONData.DataType) throws -> [Any] {
        // 값 패턴만 추출.
        var stringValues: [String] = []
        switch type {
        case .object:
            let elements = data.split(separator: ",").map { String($0) }
            for element in elements {
                let valueRange = element.index(after: element.index(of: ":")!)..<element.endIndex
                let value = String(element[valueRange])
                stringValues.append(value)
            }
        case .array:
            stringValues = try data.splitPattern(by: GrammarChecker.arrayValuePattern)
        }
        // 문자열 값을 실제 값으로 변환.
        let realValues = try makeRealData(from: stringValues)
        return realValues
    }
    
    // 문자열 데이터를 실제 값 데이터로 변환.
    private static func makeRealData(from stringValues: [String]) throws -> [Any] {
        var resultValues: [Any] = []
        for value in stringValues {
            if value.contains("[") {    // 객체 형태의 데이터인 경우.
                let convertedArray = try convertStringToAnyArray(from: value, ofType: .array)
                resultValues.append(convertedArray)
            }else if value.contains("{") {
                let convertedObject = try convertStringToAnyArray(from: value, ofType: .object)
                resultValues.append(convertedObject)
            }else {                     // 기본 데이터인 경우.
                guard let convertedValue = try convertStringToAny(from: value) else { break }
                resultValues.append(convertedValue)
            }
        }
        return resultValues
    }
    
    // 객체 형태 문자열 데이터를 실제 객체로 변환.
    private static func convertStringToAnyArray(from data: String, ofType type: JSONData.DataType) throws -> [Any] {
        var arrayValue: [Any] = []
        // data = 내부배열. elements = 내부배열 내의 각 문자열 데이터.(정규표현식을 쓰려고 했으나 오류남)
        var elements: [String] = []
        switch type {
        case .array:
            elements = data.trimmingCharacters(in: ["[","]"]).split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            for element in elements {
                // 내부배열 내의 각 문자열 데이터를 실제 데이터로 변환.
                guard let convertedValue = try convertStringToAny(from: element) else { break }
                arrayValue.append(convertedValue)
            }
        case .object:
            var convertedValue: [String:Any] = [:]
            elements = data.trimmingCharacters(in: ["{","}"]).split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            for element in elements {
                convertedValue = try convertToDictionary(from: element)
                arrayValue.append(convertedValue.popFirst()!)
            }
        }
        return arrayValue
    }
    
    // 기본값 형태 문자열 데이터를 실제 값으로 변환.
    private static func convertStringToAny(from data: String) throws -> Any? {
        var data = data
        data = data.trimmingCharacters(in: [" "])
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
