//
//  ExtractData.swift
//  JSONParser
//
//  Created by 윤동민 on 19/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String {
    // 정규식 조건에 맞는 스트링 리턴
    func getArrayAfterRegex(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}

struct ExtractData {
    private let boolPattern : String
    private let stringPattern : String
    private let numberPattern : String
    private let objectPropertyPattern : String
    private let objectPattern : String
    private let arrayExtractDataPattern : String
    private let allArrayDataType : String
    private let allObjectPropertyType : String
    private let objectPropertyValuePattern : String
    
    init() {
        boolPattern = "(true|false)"
        stringPattern = "\"[a-zA-Z0-9\\s]+\""
        numberPattern = "[0-9]+"
        objectPropertyValuePattern = "(\(boolPattern)|\(numberPattern)|\(stringPattern))"
        objectPropertyPattern = "\(stringPattern)\\s?:\\s?(\(stringPattern)|\(boolPattern)|\(numberPattern))"
        objectPattern = "\\{\\s?\(objectPropertyPattern)\\s?(,\\s?\(objectPropertyPattern)\\s?)*\\s?\\}"
        arrayExtractDataPattern = "(\(objectPattern)|\(boolPattern)|\(stringPattern)|\(numberPattern))"
        allArrayDataType = "(\(objectPattern)|\(boolPattern)|\(stringPattern)|\(numberPattern)|[a-zA-Z0-9]+)"
        allObjectPropertyType = "(\(stringPattern)\\s?:\\s?(\(stringPattern)|\(boolPattern)|\(numberPattern)))|[a-zA-Z0-9]+"
    }
    
    // 객체의 프로퍼티 Value 값으로 쓰일 수 있는 값 추출
    func propertyValueExtract(data : String) -> String {
        return data.getArrayAfterRegex(regex: objectPropertyValuePattern)[0]
    }
    
    // 객체의 프로퍼티 Key 값으로 쓰일 수 있는 값 추출
    func propertyKeyExtract(data : String) -> String {
        return data.getArrayAfterRegex(regex: stringPattern)[0]
    }
    
    // 배열의 데이터를 추출
    func arrayDataExtract(arrayData : String) -> [String] {
        return arrayData.getArrayAfterRegex(regex: arrayExtractDataPattern)
    }
    
    // 객체의 데이터를 추출
    func objectDataExtract(objectData : String) -> [String] {
        return objectData.getArrayAfterRegex(regex: objectPropertyPattern)
    }
    
    // 배열 안에 있는 모든 데이터 반환
    func inArrayAllDataType(data : String) -> [String] {
        return data.getArrayAfterRegex(regex: allArrayDataType)
    }
    
    // 객체 안에 있는 모든 프로퍼티 데이터 반환
    func inObjectAllDataType(data : String) -> [String] {
        return data.getArrayAfterRegex(regex: allObjectPropertyType)
    }
}
