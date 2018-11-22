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
    private func allDataConvertInArray(_ allDataInArray : [String]) -> Array<InArraySwiftType>{
        var convertedArray : [InArraySwiftType] = []
        for eachData in allDataInArray {
            convertedArray.append(jsonToSwiftTypeInArray(json: eachData))
        }
        return convertedArray
    }
    
    // Array 안 데이터 변환
    private func jsonToSwiftTypeInArray(json : String) -> InArraySwiftType{
        let typeChecker : TypeChecker = TypeChecker()
        guard let dataType = typeChecker.supportingTypeInArray(json) else { return "" }
        switch dataType {
        case .stringType:
            return stringConvert(json)
        case .booleanType:
            return booleanConvert(json)
        case .numberType:
            return numberConvert(json)
        case .objectType:
            return objectConvert(json)
        }
    }
    
    // Object 안 데이터 변환
    private func jsonToSwiftTypeInObject(_ json : String) -> InObjectSwiftType {
        let typeChecker : TypeChecker = TypeChecker()
        guard let dataType = typeChecker.supportingTypeInObject(json) else { return "" }
        switch dataType {
        case .stringType:
            return stringConvert(json)
        case .booleanType:
            return booleanConvert(json)
        case .numberType:
            return numberConvert(json)
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
    private func objectConvert(_ json : String) -> Dictionary<String, InObjectSwiftType> {
        let extractData : ExtractData = ExtractData()
        let objectProperties : [String] = extractData.objectDataExtract(objectData: json)
        var keyAndValue : [String]
        var propertyKey : String
        var propertyValue : String
        var jsonObjectToSwiftDic : [String : InObjectSwiftType] = [:]
        
        for eachProperty in objectProperties {
            keyAndValue = eachProperty.split(separator: ":").map(String.init)
            propertyKey = extractData.propertyKeyExtract(data: keyAndValue[0])
            propertyValue = extractData.propertyValueExtract(data: keyAndValue[1])
            jsonObjectToSwiftDic.updateValue(jsonToSwiftTypeInObject(propertyValue), forKey: stringConvert(propertyKey))
        }
        return jsonObjectToSwiftDic
    }
}
