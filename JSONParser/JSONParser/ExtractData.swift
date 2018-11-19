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
    private let notSupprotingArrayDataType : String
    private let notSupportingObjectProperty : String
    
    init() {
        boolPattern = "(true|false)"
        stringPattern = "\"[a-zA-Z0-9\\s]+\""
        numberPattern = "[0-9]+"
        objectPropertyPattern = "\(stringPattern)\\s?:\\s?(\(stringPattern)|\(boolPattern)|\(numberPattern))"
        objectPattern = "\\{\\s?\(objectPropertyPattern)\\s?(,\\s?\(objectPropertyPattern)\\s?)*\\s?\\}"
        arrayExtractDataPattern = "(\(objectPattern)|(\(boolPattern)|\(stringPattern)|\(numberPattern))"
        notSupprotingArrayDataType = "[^(\(objectPattern)|(\(boolPattern)|\(stringPattern)|\(numberPattern)|\\[|\\])]"
        notSupportingObjectProperty = "[^\(objectPropertyPattern)\\s?(,\\s?\(objectPropertyPattern)\\s?)*|\\{,\\}]"
    }
    
    // 배열의 데이터를 추출
    func arrayDataExtract(arrayData : String) -> [String] {
        return arrayData.getArrayAfterRegex(regex: arrayExtractDataPattern)
    }
    
    // 객체의 데이터를 추출
    func objectDataExtract(objectData : String) -> [String] {
        return objectData.getArrayAfterRegex(regex: objectPropertyPattern)
    }
    
    // 지원하지 않는 타입을 리턴
    func notSupportingArrayDataType(data : String) -> [String] {
        return data.getArrayAfterRegex(regex: notSupprotingArrayDataType)
    }
    
    // 객체의 프로퍼티 중 지원하지 않는 프로퍼티 리턴
    func notSupportingPropertyType(data : String) -> [String] {
        return data.getArrayAfterRegex(regex: notSupportingObjectProperty)
    }
}
