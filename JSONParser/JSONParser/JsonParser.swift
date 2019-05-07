//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    /// 배열 내의 원소가 어떤 타입인지 판단하는 함수
    func parsingData(beforeData : String) throws -> Json {
        var convertedElement: Json
        if beforeData.contains("\"") {
            convertedElement = TypeString.init(json: beforeData)
        } else if let _ = Int(beforeData) {
            convertedElement = TypeInt.init(json: beforeData)
        } else if let _ = Bool(beforeData) {
            convertedElement = TypeBool.init(json: beforeData)
        } else {
            throw ErrorMessage.wrongValue
        }
        return convertedElement
    }
    /// [Json] 타입의 배열을 생성하는 함수
    func buildArray(inputdata: String) throws -> [Json] {
        var jsonData : [Json] = []
        var data = inputdata
        data.removeFirst()
        data.removeLast()
        let refinedData = data.components(separatedBy: ",").filter { $0 != "" }
        for dataElement in refinedData {
            let jsonDatum = try parsingData(beforeData: dataElement)
            jsonData.append(jsonDatum)
        }
        return jsonData
    }
    
}
