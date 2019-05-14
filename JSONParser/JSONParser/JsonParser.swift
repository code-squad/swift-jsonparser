//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    let frontCurlyBracket = Bracket.frontCurly.rawValue
    let backCurlyBracket = Bracket.backCurly.rawValue
    let frontSquareBracket = Bracket.frontSquare.rawValue
    let backSquareBracket = Bracket.backSquare.rawValue
    
    /// 입력받은 문자열이 nil인지 아닌지 판단 및 옵셔널 바인딩 함수
    private func distinctNil(input: String?) throws -> String {
        guard let notOptionalText: String = input else { throw ErrorMessage.wrongValue }
        return notOptionalText
    }
    /// 배열이나 객체의 형태를 띄고 있는 문자열을 배열을 형태로 나누어 주는 함수
    private func isolatingString(input: String) -> String {
        var insteadInput = input
        insteadInput.removeFirst()
        insteadInput.removeLast()
        return insteadInput
    }
    /// 입력받은 String의 양끝에 "[","]" 또는 "{","}" 유무를 판단하여 정보를 넘기는 함수
    private func distinctArray(inputData: String) throws -> (input: String, distinctMent: String) {
        switch (inputData.first, inputData.last) {
        case (frontCurlyBracket,backCurlyBracket): return (inputData, DataMent.dictionaryMent.rawValue)
        case(frontSquareBracket,backSquareBracket): return (inputData, DataMent.arrayMent.rawValue)
        default: throw ErrorMessage.notArray
        }
    }
    /// 배열 내의 원소가 어떤 타입인지 판단하는 함수
    func parsingData(beforeData : String) throws -> Json {
        var convertedElement: Json
        let afterData = beforeData.trimmingCharacters(in: .whitespacesAndNewlines)
        if afterData.first == frontCurlyBracket, afterData.last == backCurlyBracket {
            let distinctAfterData = try distinctArray(inputData: afterData)
            let dictionaryData = isolatingString(input: distinctAfterData.input)
            let isolatedDictionaryData = dictionaryData.components(separatedBy: ",").filter{ $0 != "" }
            for dictionaryDatum in isolatedDictionaryData {
                _ = try valueOfArrayOrDistinct(dataElement: dictionaryDatum, dataMent: distinctAfterData.distinctMent)
            }
            convertedElement = try TypeDictionary(json: distinctAfterData.input)
        } else if afterData.contains("\"") {
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
        if dataElement.contains(":"), dataMent == DataMent.dictionaryMent.rawValue {
            refinedDatum = try ifKeyExist(dictionaryDataElement: dataElement)
        } else if dataMent == DataMent.arrayMent.rawValue {
            refinedDatum = dataElement
        } else {
            throw ErrorMessage.wrongValue
        }
        return refinedDatum
    }
    /// 입력한 데이터의 내부에 객체가 존재할 경우 데이터를 나누는 함수
    private func dictionaryInArray(input: String) -> [String] {
        var dictionaryInData = input.components(separatedBy: ["{","}"]).filter{ $0 != "" }
        for index in 0..<dictionaryInData.count {
            if dictionaryInData[index].first == "," || dictionaryInData[index].last == "," {
                dictionaryInData[index] = dictionaryInData[index].replacingOccurrences(of: ",", with: "|")
            }
        }
        for index in 0..<dictionaryInData.count {
            if dictionaryInData[index].contains("\":") {
                dictionaryInData[index] = "\(frontCurlyBracket)" + dictionaryInData[index] + "\(backCurlyBracket)"
            }
        }
        let dataReJoined = dictionaryInData.joined()
        dictionaryInData = dataReJoined.components(separatedBy: "|")
        return dictionaryInData
    }
    /// [Json] 타입의 배열을 생성하는 함수
    func buildArray(inputData: String?) throws -> (json: [Json],dataMent: String) {
        var jsonData : [Json] = []
        var isolatedData : [String]
        let input = try distinctNil(input: inputData)
        let data = try distinctArray(inputData: input)
        let refinedData = isolatingString(input: data.input)
        if refinedData.contains(frontCurlyBracket), refinedData.contains(backCurlyBracket) {
            isolatedData = dictionaryInArray(input: refinedData).filter{ $0 != "" }
        } else {
            isolatedData = refinedData.components(separatedBy: ",").filter{ $0 != "" }
        }
        for dataElement in isolatedData {
            let refinedDatum = try valueOfArrayOrDistinct(dataElement: dataElement, dataMent: data.distinctMent)
            let jsonDatum = try parsingData(beforeData: refinedDatum)
            jsonData.append(jsonDatum)
        }
        return (json: jsonData, dataMent: data.distinctMent)
    }
}
