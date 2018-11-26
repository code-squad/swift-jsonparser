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
    private let allValuePattern : String
    private let nestedElementValue : String
    private let arrayPattern : String
    private let nestedArray : String
    private let nestedObject : String
    private let notSupportingArrayNestedPattern : String
    private let notSupportingObjectNestedPattern : String
    
    init() {
        boolPattern = "(true|false)"
        stringPattern = "\"[a-zA-Z0-9\\s]+\""
        numberPattern = "[0-9]+"
        nestedElementValue = "(\(boolPattern)|\(numberPattern)|\(stringPattern))"
        nestedArray = "\\[\\s?\(nestedElementValue)\\s?(,\\s?\(nestedElementValue))*\\s?\\]"
        nestedObject = "\\{\\s?\(stringPattern)\\s?:\\s?\(nestedElementValue)\\s?(,\\s?\(stringPattern)\\s?:\\s?\(nestedElementValue)\\s?)*\\s?\\}"
        objectPropertyPattern = "\(stringPattern)\\s?:\\s?(\(nestedObject)|\(stringPattern)|\(boolPattern)|\(numberPattern)|\(nestedArray))"
        objectPattern = "\\{\\s?\(objectPropertyPattern)\\s?(,\\s?\(objectPropertyPattern)\\s?)*\\s?\\}"
        allValuePattern = "(\(nestedArray)|\(nestedObject)|\(boolPattern)|\(stringPattern)|\(numberPattern))"
        arrayPattern = "\\[\\s?\(allValuePattern)\\s?(,\\s?\(allValuePattern))*\\s?\\]"
        notSupportingArrayNestedPattern = "(\\[\\s?.*\\s?\\[\\s?.*\\s?\\[\\s?.*\\s?\\]\\s?.*\\s?\\]\\s?.*\\s?\\])|(\\[\\s?.*\\s?\\[\\s?.*\\s?\\{\\s?.*\\s?\\}\\s?.*\\s?\\]\\s?.*\\s?\\])|(\\[\\s?.*\\s?\\{\\s?.*\\s?:\\s?\\[\\s?.*\\s?\\]\\s?.*\\s?\\}\\s?.*\\])|(\\[\\s?.*\\s?\\{\\s?.*\\s?\\{\\s?.*\\s?\\}\\s?.*\\s?\\}\\s?.*\\s?\\])"
        notSupportingObjectNestedPattern = "(\\{\\s?.*\\s?\\{\\s?.*\\s?\\{\\s?.*\\s?\\}\\s?.*\\s?\\}\\s?.*\\s?\\})|(\\{\\s?.*\\s?\\[\\s?.*\\s?\\{\\s?.*\\s?\\}\\s?.*\\s?\\]\\s?.*\\s?\\})|(\\{\\s?.*\\s?\\[\\s?.*\\s?\\[\\s?.*\\s?\\]\\s?.*\\s?\\]\\s?.*\\s?\\})|(\\{\\s?.*\\s?\\{\\s?.*\\s?\\[\\s?.*\\s?\\]\\s?.*\\s?\\}\\s?.*\\s?\\})"
        
    }
    
    // 객체의 프로퍼티 Value 값으로 쓰일 수 있는 값 추출
    func propertyValueExtract(data : String) -> String {
        return data.getArrayAfterRegex(regex: allValuePattern)[1]
    }
    
    // 객체의 프로퍼티 Key 값으로 쓰일 수 있는 값 추출
    func propertyKeyExtract(data : String) -> String {
        return data.getArrayAfterRegex(regex: stringPattern)[0]
    }
    
    // 배열의 데이터를 추출
    func arrayDataExtract(arrayData : String) -> [String] {
        return arrayData.getArrayAfterRegex(regex: allValuePattern)
    }
    
    // 중첩된 배열 안의 데이터 추출
    func arrayNestedDataExtract(arrayData : String) -> [String] {
        return arrayData.getArrayAfterRegex(regex: nestedElementValue)
    }
    
    // 3중 이상으로 중첩된 Array 데이터 추출
    func notSupportingNestedArrayElementExtract(arrayData : String) -> [String] {
        return arrayData.getArrayAfterRegex(regex: notSupportingArrayNestedPattern)
    }
    
    // 3중 이상으로 중첩된 Object 데이터 추출
    func notSupportingNestedObjectElementExtract(objectData : String) -> [String] {
        return objectData.getArrayAfterRegex(regex: notSupportingObjectNestedPattern)
    }
    
    // 객체의 데이터를 추출
    func objectDataExtract(objectData : String) -> [String] {
        return objectData.getArrayAfterRegex(regex: objectPropertyPattern)
    }
    
    // 배열 형식 추출
    func arrayExtract(data : String) -> [String] {
        return data.getArrayAfterRegex(regex: arrayPattern)
    }
    
    // 객체 형식 추출
    func objectExtract(data : String) -> [String] {
        return data.getArrayAfterRegex(regex: objectPattern)
    }
}
