//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    /// 입력받은 String의 양끝에 "[","]"가 있는지 판단하는 함수
    private func distinctArray(inputdata: String?) throws -> String {
        if let input: String = inputdata {
            switch (input.first, input.last) {
            case ("[","]"): return input
            case("{","}"): return input
            default: throw ErrorMessage.notArray
            }
        } else { throw ErrorMessage.notArray }
    }
    /// 배열 내의 원소가 어떤 타입인지 판단하는 함수
    private func parsingData(beforeData : String) throws -> Json {
        var convertedElement: Json
        let afterData = beforeData.trimmingCharacters(in: .whitespacesAndNewlines)
        if afterData.contains("\"") {
            convertedElement = TypeString.init(json: afterData)
        } else if let _ = Int(afterData) {
            convertedElement = TypeInt.init(json: afterData)
        } else if let _ = Bool(afterData) {
            convertedElement = TypeBool.init(json: afterData)
        } else {
            throw ErrorMessage.wrongValue
        }
        return convertedElement
    }
    /// [Json] 타입의 배열을 생성하는 함수
    func buildArray(inputdata: String?) throws -> [Json] {
        var jsonData : [Json] = []
        var data = try distinctArray(inputdata: inputdata)
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
