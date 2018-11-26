//
//  JSONParser.swift
//  JSONParser
//
//  Created by 윤동민 on 02/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // JSON 모든 데이터를 SWIFT 데이터 타입 배열에 저장
    func jsonParser(dataToConvert : String) -> JSONType {
        let extractData : ExtractData = ExtractData()
        let typeChecker : GrammarChecker = GrammarChecker()
        
        if typeChecker.IsArrayType(dataToConvert) { return convertAllDataInArray(extractData.arrayDataExtract(arrayData: dataToConvert)) }
        else { return convertObject(dataToConvert) }
    }
    
    // Array 안의 모든 JSON 데이터를 Swift 형식의 데이터로 전환
    private func convertAllDataInArray(_ allDataInArray : [String]) -> Array<InSetJSONType>{
        var convertedArray : [InSetJSONType] = []
        for eachData in allDataInArray {
            convertedArray.append(jsonToSwiftTypeInSetMember(json: eachData))
        }
        return convertedArray
    }
    
    // Array 안 데이터 변환
    private func jsonToSwiftTypeInSetMember(json : String) -> InSetJSONType{
        let typeChecker : GrammarChecker = GrammarChecker()
        guard let dataType = typeChecker.checkSupportingTypeInSet(json) else { return "" }
        switch dataType {
        case is String: return convertString(json)
        case is Bool: return convertBoolean(json)
        case is Int: return convertNumber(json)
        case is Dictionary<String, InSetJSONType>: return convertObject(json)
        case is Array<InSetJSONType>: return convertArray(json)
        default: return ""
        }
    }
    
    // JSON 문자열 -> Swift 문자열
    private func convertString(_ json : String) -> String {
        var json = json
        json.remove(at: json.startIndex)
        json.remove(at: json.index(before: json.endIndex))
        return json
    }
    
    // JSON 부울 -> Swift 부울
    private func convertBoolean(_ json : String) -> Bool {
        guard json == "true" else { return false }
        return true
    }
    
    // JSON 숫자 -> Swift 숫자
    private func convertNumber(_ json : String) -> Int {
        return Int(json) ?? 0
    }
    
    // JSON Object -> Swfit Dictionary
    private func convertObject(_ json : String) -> Dictionary<String, InSetJSONType> {
        let extractData : ExtractData = ExtractData()
        let objectProperties : [String] = extractData.objectDataExtract(objectData: json)
        var propertyKey : String
        var propertyValue : String
        var jsonObjectToSwiftDic : [String : InSetJSONType] = [:]
        
        for eachProperty in objectProperties {
            propertyKey = extractData.propertyKeyExtract(data: eachProperty)
            propertyValue = extractData.propertyValueExtract(data: eachProperty)
            jsonObjectToSwiftDic.updateValue(jsonToSwiftTypeInSetMember(json: propertyValue), forKey: convertString(propertyKey))
        }
        return jsonObjectToSwiftDic
    }
    
    // JSON Array -> Swift Array
    private func convertArray(_ json : String) -> Array<InSetJSONType> {
        let extractData : ExtractData = ExtractData()
        let arrayElement : [String] = extractData.arrayNestedDataExtract(arrayData: json)
        var swiftArray : [InSetJSONType] = []
        
        for eachElement in arrayElement { swiftArray.append(jsonToSwiftTypeInSetMember(json: eachElement)) }
        return swiftArray
    }
}
