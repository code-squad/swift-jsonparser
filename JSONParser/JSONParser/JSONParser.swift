//
//  JSONParser.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    enum JsonError: String, Error {
        case invalidPattern = "JSON 규격에 맞게 입력해주세요."
    }
    
    // 문자열을 JSONData로 파싱하여 배열로 반환.
    static func parse(_ rawData: String) throws -> [JSONData] {
        let preprocessData = trimExceptDataInside(of: rawData)
        // 배열 데이터와 객체 데이터로 나눔.
        let objects = try extractObjectBlobs(from: preprocessData)
        let arrays = try extractArrayBlobs(from: preprocessData)
        // 배열 blob, 객체 blob에 따라 각각 JSONData 객체들을 만들어 배열로 받음.
        let jsonObjects = try generateJSONData(from: objects, ofType: JSONData.DataType.object)
        let jsonArrays = try generateJSONData(from: arrays, ofType: JSONData.DataType.array)
        // 모든 JSONData 배열 반환.
        return jsonObjects+jsonArrays
    }
    
    // 사용자 입력값의 내부 데이터만 반환.
    private static func trimExceptDataInside(of rawData: String) -> String {
        let secondCharacter = rawData[rawData.index(after: rawData.startIndex)]
        // 두 번째 글자가 '[','{'가 아닐 때, 가장 바깥쪽 대괄호가 없다고 판단. 즉, 객체 1개나 배열 1개가 입력됐다고 판단.
        if secondCharacter != "[" && secondCharacter != "{" {
            // 입력된 그대로 반환.
            return rawData
        }else {
            // 가장 바깥쪽 대괄호를 지우고 반환.
            return removeSquareBracket(from: rawData)
        }
    }
    
    // 가장 바깥쪽 대괄호 제거.
    private static func removeSquareBracket(from data: String) -> String {
        // 가장 바깥쪽 대괄호를 제외한 범위.
        let rangeWithoutSquareBracket = data.index(after: data.startIndex)..<data.index(before: data.endIndex)
        let dataWithoutSquareBracket = data[rangeWithoutSquareBracket]
        return String(dataWithoutSquareBracket)
    }
    
    private static let JSONObjectPattern = "\\[(.+?(?!\\{\\[\\]))\\]"
    private static let JSONArrayPattern  = "\\{(.+?(?!\\{\\[\\]))\\}"
    
    // blob 단위 JSONData 배열 반환.
    private static func generateJSONData(from blobs: [String], ofType type: JSONData.DataType) throws -> [JSONData] {
        var jsonDataCollection: [JSONData] = []
        // blob = [], {} 들의 배열
        let blob = blobs.map { $0.trimmingCharacters(in: [","]) }
        // data = [], {} 각각의 내부 데이터
        for data in blob {
            // datum = 내부 데이터들의 배열
            let datum = data.split(separator: ",").map { return String($0) }
            jsonDataCollection.append(JSONData(convertToDictionary(from: datum), ofType: type))
        }
        return jsonDataCollection
    }
    
    // 각 blob 내부 데이터들로 딕셔너리 생성하여 반환.
    private static func convertToDictionary(from datum: [String]) -> [String:Any] {
        var result: [String:Any] = [:]
        // element = 각 내부 데이터
        for element in datum {
            let key = generateKey(from: element)
            guard let value = generateValue(from: element) else { break }
            result.updateValue(value, forKey: key)
        }
        return result
    }
    
    // 문자열 딕셔너리에서 key 값 추출.
    private static func generateKey(from data: String) -> String {
        let keyRange = data.startIndex..<data.index(of: ":")!
        return String(data[keyRange]).trimmingCharacters(in: ["\""])
    }
    
    // 문자열 딕셔너리에서 value 값 추출 및 실제 value 타입으로 캐스팅.
    private static func generateValue(from data: String) -> Any? {
        let valueRange = data.index(of: ":")!..<data.endIndex
        let value = String(data[valueRange]).trimmingCharacters(in: [":"])
        if value.contains("\"") {
            return value.trimmingCharacters(in: ["\""])
        }else if let numberElement = JSONData.Number(value) {
            return numberElement
        }else if let boolElement = Bool(value){
            return boolElement
        }else {
            return nil
        }
    }
    
    // 문자열에서 객체 패턴([..])인 문자열 배열 반환.
    private static func extractObjectBlobs(from rawData: String) throws -> [String] {
        // 객체 패턴으로 문자열데이터 자름.
        let objectBlobs = try rawData.splitPattern(by: JSONObjectPattern)
        let objectBlobsWithoutSquareBracket = objectBlobs.map { return removeBrackets(of: $0) }
        return objectBlobsWithoutSquareBracket
    }
    
    // 문자열에서 배열 패턴({..})인 문자열 배열 반환.
    private static func extractArrayBlobs(from rawData: String) throws -> [String] {
        // 배열 패턴으로 문자열데이터 자름.
        let arrayBlobs = try rawData.splitPattern(by: JSONArrayPattern)
        let arrayBlobsWithoutParenthesis = arrayBlobs.map { return removeBrackets(of: $0) }
        return arrayBlobsWithoutParenthesis
    }
    
    // 괄호 제거({} 또는 []) - 데이터 자체에 괄호가 포함돼 있을 수 있으므로 양끝만 제거.
    private static func removeBrackets(of eachData: String) -> String {
        let rangeWithoutParenthesis = eachData.index(after: eachData.startIndex)..<eachData.index(before: eachData.endIndex)
        return String(eachData[rangeWithoutParenthesis])
    }
    
}

