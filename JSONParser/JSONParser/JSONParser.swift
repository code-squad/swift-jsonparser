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
        let typeChecker : TypeChecker = TypeChecker()
        
        if typeChecker.IsArrayType(dataToConvert) { return allDataConvertInArray(extractData.arrayDataExtract(arrayData: dataToConvert)) }
        else { return objectConvert(dataToConvert) }
    }
    
    // Array 안의 모든 JSON 데이터를 Swift 형식의 데이터로 전환
    private func allDataConvertInArray(_ allDataInArray : [String]) -> Array<InSetJSONType>{
        var convertedArray : [InSetJSONType] = []
        for eachData in allDataInArray {
            convertedArray.append(jsonToSwiftTypeInSetMember(json: eachData))
        }
        return convertedArray
    }
    
    // Array 안 데이터 변환
    private func jsonToSwiftTypeInSetMember(json : String) -> InSetJSONType{
        let typeChecker : TypeChecker = TypeChecker()
        guard let dataType = typeChecker.supportingTypeInSet(json) else { return "" }
        switch dataType {
        case is String: return stringConvert(json)
        case is Bool: return booleanConvert(json)
        case is Int: return numberConvert(json)
        case is Dictionary<String, InSetJSONType>: return objectConvert(json)
        case is Array<InSetJSONType>: return arrayConvert(json)
        default: return ""
        }
    }
    
    // JSON 문자열 -> Swift 문자열
    private func stringConvert(_ json : String) -> String {
        var json = json
        json.remove(at: json.startIndex)
        json.remove(at: json.index(before: json.endIndex))
        return json
    }
    
    // JSON 부울 -> Swift 부울
    private func booleanConvert(_ json : String) -> Bool {
        guard json == "true" else { return false }
        return true
    }
    
    // JSON 숫자 -> Swift 숫자
    private func numberConvert(_ json : String) -> Int {
        return Int(json) ?? 0
    }
    
    // JSON Object -> Swfit Dictionary
    private func objectConvert(_ json : String) -> Dictionary<String, InSetJSONType> {
        let extractData : ExtractData = ExtractData()
        let objectProperties : [String] = extractData.objectDataExtract(objectData: json)
        var propertyKey : String
        var propertyValue : String
        var jsonObjectToSwiftDic : [String : InSetJSONType] = [:]
        
        for eachProperty in objectProperties {
            propertyKey = extractData.propertyKeyExtract(data: eachProperty)
            propertyValue = extractData.propertyValueExtract(data: eachProperty)
            jsonObjectToSwiftDic.updateValue(jsonToSwiftTypeInSetMember(json: propertyValue), forKey: stringConvert(propertyKey))
        }
        return jsonObjectToSwiftDic
    }
    
    // JSON Array -> Swift Array
    private func arrayConvert(_ json : String) -> Array<InSetJSONType> {
        let extractData : ExtractData = ExtractData()
        let arrayElement : [String] = extractData.arrayNestedDataExtract(arrayData: json)
        var swiftArray : [InSetJSONType] = []
        
        for eachElement in arrayElement { swiftArray.append(jsonToSwiftTypeInSetMember(json: eachElement)) }
        return swiftArray
    }
}
