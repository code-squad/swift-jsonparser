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
    private let allPattern : String
    private let fileReaderOrder : String
    
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
        allPattern = "(\(arrayPattern))|(\(objectPattern))"
        fileReaderOrder = "jsonparser\\s.+(//s.*){0,1}"
    }
    
    // 정규식과 일치하는 문자열의 NSRange을 찾음
    func searchRange(stringForRange : String) -> NSRange{
        let regex = try? NSRegularExpression(pattern: allPattern, options: .caseInsensitive)
        return regex?.rangeOfFirstMatch(in: stringForRange, options: [], range: NSRange(stringForRange.startIndex..., in: stringForRange)) ?? NSRange()
    }
    
    // file 읽어오는 명령어를 추출
    func searchFileReadOrder(in order : String) -> Bool {
        let regex = try? NSRegularExpression(pattern: fileReaderOrder, options: .caseInsensitive)
        guard regex?.numberOfMatches(in: order, options: [], range: NSRange(order.startIndex..., in: order)) == 1 else { return false }
        return true
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
    
    // 객체의 데이터를 추출
    func objectDataExtract(objectData : String) -> [String] {
        return objectData.getArrayAfterRegex(regex: objectPropertyPattern)
    }
}
