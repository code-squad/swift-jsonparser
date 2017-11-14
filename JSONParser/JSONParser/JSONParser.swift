//
//  JSONParser.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    func check(_ value: String?) throws -> String {
        guard let safeValue = value else {
            throw ErrorCode.invalidInputString
        }
        if safeValue.hasPrefix("[") {
            return safeValue
        } else if safeValue.hasPrefix("{"){
            return safeValue
        } else {
            throw ErrorCode.invalidJSONStandard
        }
    }
    
    func makeJSONData(_ value: String) -> JSONData {
        if value.hasPrefix("{") {
            let objectJSON = makeObjectJSONData(value)
            return objectJSON
        } else {
            let arrayJSON = makeArrayJSONData(value)
            return arrayJSON
        }
        // 최초입력값이 객체면 다르게 움직여야함.
        // 배열의 단순 값만 있는거라면 아래의 로직대로 진행해도된다.
        // 최초입력값이 배열인데 배열안에 객체가 있는경우는 다르게 움직여야함.
        // ","로 분해 후 객체 분해기 를 불러들여서 움직여야한다.
        // 즉 3가지로 나뉨.
        // 1. 입력값이 배열인데 배열안에 단순한 값이 있는건가
        // 2. 입력값이 객체라 객체를 처리해야한다.
        // 3. 입력값이 배열인데 내부에 객체가 있다. (이럴경우 단순 배열 처리(앞 뒤 bracket 제거 후 "," 로 나눈다음 공백제거 까진 똑같다!.
        
        
        // 위의 3번의 경우처럼 공백 제거 까지 했는데 안에 객체가 있다. 그러면 객체 분열기를 호출해야한다.
        // 그럼 최초 입력이 배열일 경우 배열에 공백을 제거한 후에 안의 값이 객체인지 검사해야한다. 객체가 아니면 아래의 로직으로 실행해도 된다.
        //
        
    }
    

    
    private func makeArrayJSONData(_ rawJSON: String) -> JSONData {
        let separateJSON = processBeforeMakingJSON(rawJSON)
        var jsonData: JSONData
        let removedWhiteSpaceJSON = separateJSON.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        if removedWhiteSpaceJSON[0].hasPrefix("{") {
            jsonData = makeObjectJSONData(rawJSON)
            return jsonData
        }
        jsonData = JSONData(sortJSONType(removedWhiteSpaceJSON))
        return jsonData
    }

    private func makeObjectJSONData(_ rawJSON: String) -> JSONData {
        var objectTypeJSON = [String:Any]()
        let separateJSON = processBeforeMakingJSON(rawJSON)
        for objectComponents in separateJSON {
            let separateObject = objectComponents.components(separatedBy: ":")
            let key = hasStringType(separateObject[0].trimmingCharacters(in: .whitespacesAndNewlines)) 
            let objectValue = separateObject[1].trimmingCharacters(in: .whitespacesAndNewlines)
            objectTypeJSON[key] = sortJSONData(objectValue)
        }
        return JSONData(objectTypeJSON)
    }
    
    private func processBeforeMakingJSON(_ value: String) -> [String] {
        var rawJSON = value
        rawJSON.removeFirst()
        rawJSON.removeLast()
        let separateRawJSON = rawJSON.components(separatedBy: ",")
        return separateRawJSON
    }
    
    private func sortJSONType(_ value: [String]) -> [Any] {
        var jsonData = [Any]()
        for sortedJSON in value {
            jsonData.append(sortJSONData(sortedJSON))
        }
        return jsonData
    }
    
    private func sortJSONData(_ value: String) -> Any {
        if let boolType = Bool(value) {
            return boolType
        } else if let intType = Int(value) {
            return intType
        }
        return hasStringType(value)
    }
    
    private func hasStringType(_ value: String) -> String{
        var pureString = value
        pureString.removeFirst()
        pureString.removeLast()
        return pureString
    }

}

