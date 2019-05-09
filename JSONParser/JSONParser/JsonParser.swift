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
    private func distinctArray(inputdata: String?) throws -> (input: String, distinctMent: String) {
        if let input: String = inputdata {
            switch (input.first, input.last) {
            case ("[","]"): return (input, "배열")
            case("{","}"): return (input, "객체")
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
    /// 입력된 원소에 key값이 있는 데이터인 경우 값만을 리턴하는 함수
    private func ifKeyExist(dictionaryDataElement: String) throws -> String{
        let refinedDatum = dictionaryDataElement.components(separatedBy: ":")
        if refinedDatum.count != 2 {
            throw ErrorMessage.wrongValue
        } else if refinedDatum[0].contains("\"") == false {
            throw ErrorMessage.wrongKey
        }else {
            return refinedDatum[1]
        }
    }
    /// 입력된 문자열이 배열인지 딕셔너리인지 판단하고, 이에 맞는 원소들을 확인하는 함수
    private func valueOfArrayOrDistinct(dataElement: String, dataMent: String) throws -> String{
        var refinedDatum: String
        if dataElement.contains(":"), dataMent == "객체" {
            refinedDatum = try ifKeyExist(dictionaryDataElement: dataElement)
        } else if dataElement.contains(":") == false, dataMent == "배열" {
            refinedDatum = dataElement
        } else {
            throw ErrorMessage.wrongValue
        }
        return refinedDatum
    }
    /// [Json] 타입의 배열을 생성하는 함수
    func buildArray(inputdata: String?) throws -> (json: [Json],dataMent: String) {
        var jsonData : [Json] = []
        var data = try distinctArray(inputdata: inputdata)
        data.input.removeFirst()
        data.input.removeLast()
        let refinedData = data.input.components(separatedBy: ",").filter { $0 != "" }
        for dataElement in refinedData {
            let refinedDatum = try valueOfArrayOrDistinct(dataElement: dataElement, dataMent: data.distinctMent)
            let jsonDatum = try parsingData(beforeData: refinedDatum)
            jsonData.append(jsonDatum)
        }
        return (json: jsonData, dataMent: data.distinctMent)
    }
}
