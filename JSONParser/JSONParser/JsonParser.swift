//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
/*
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
        case (Sign.frontCurlyBracket,Sign.backCurlyBracket): return (inputData, DataMent.dictionaryMent.rawValue)
        case(Sign.frontSquareBracket,Sign.backSquareBracket): return (inputData, DataMent.arrayMent.rawValue)
        default: throw ErrorMessage.notArray
        }
    }
    /// 배열 내의 원소가 어떤 타입인지 판단하는 함수
    private func parsingData(beforeData : String) throws -> Json {
        var convertedElement: Json
        let afterData = beforeData.trimmingCharacters(in: .whitespacesAndNewlines)
        if afterData.first == Sign.frontCurlyBracket, afterData.last == Sign.backCurlyBracket {
            let distinctAfterData = try distinctArray(inputData: afterData)
            let dictionaryData = isolatingString(input: distinctAfterData.input)
            let isolatedDictionaryData = dictionaryData.components(separatedBy: "\(Sign.comma)").filter{ $0 != "" }
            for dictionaryDatum in isolatedDictionaryData {
                _ = try valueOfArrayOrDistinct(dataElement: dictionaryDatum, dataMent: distinctAfterData.distinctMent)
            }
            let convertedDictionaryData = try convertDictionary(jsonData: isolatedDictionaryData)
            convertedElement = TypeDictionary.init(json: convertedDictionaryData)
        } else if let _ = Int(afterData) {
            convertedElement = TypeInt.init(json: afterData)
        } else if let _ = Bool(afterData) {
            convertedElement = TypeBool.init(json: afterData)
        } else if afterData.first == Sign.doubleQuote, afterData.last == Sign.doubleQuote {
            convertedElement = TypeString.init(json: afterData)
        } else {
            throw ErrorMessage.wrongValue
        }
        return convertedElement
    }
    /// 원소가 Dictionary타입일때 [String:Json]로 인자를 넘겨주기 위해 해당 타입으로 변환하는 함수
    private func convertDictionary(jsonData: [String]) throws -> [String:Json] {
        var jsonDictionary = [String:Json]()
        for index in 0..<jsonData.count {
            let values = jsonData[index]
            let value = try ifKeyExist(dictionaryDataElement: values)
            let keyAndValue = values.components(separatedBy: ":")
            jsonDictionary[keyAndValue[0]] = try parsingData(beforeData: value)
        }
        return jsonDictionary
    }
    /// 입력된 원소에 key값이 있는 데이터인 경우 값만을 리턴하는 함수
    private func ifKeyExist(dictionaryDataElement: String) throws -> String{
        let refinedDatum = dictionaryDataElement.components(separatedBy: "\(Sign.colon)")
        let removeBlankDatum = refinedDatum[0].trimmingCharacters(in: .whitespacesAndNewlines)
        if removeBlankDatum.first != Sign.doubleQuote || removeBlankDatum.last != Sign.doubleQuote {
            throw ErrorMessage.wrongKey
        } else if refinedDatum.count != 2 {
            throw ErrorMessage.wrongValue
        }else {
            return refinedDatum[1]
        }
    }
    /// 입력된 문자열이 배열인지 딕셔너리인지 판단하고, 이에 맞는 원소들을 확인하는 함수
    private func valueOfArrayOrDistinct(dataElement: String, dataMent: String) throws -> String{
        var refinedDatum: String
        if dataElement.contains(Sign.colon), dataMent == DataMent.dictionaryMent.rawValue {
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
        let curlyBrackets = CharacterSet(charactersIn: "\(Sign.frontCurlyBracket)+\(Sign.backCurlyBracket)")
        var dictionaryInData = input.components(separatedBy: curlyBrackets).filter{ $0 != "" }
        for index in 0..<dictionaryInData.count {
            if dictionaryInData[index].first == Sign.comma || dictionaryInData[index].last == Sign.comma {
                dictionaryInData[index] = dictionaryInData[index].replacingOccurrences(of: "\(Sign.comma)", with: "\(Sign.pipe)")
            }
        }
        for index in 0..<dictionaryInData.count {
            if dictionaryInData[index].contains(Sign.colon) {
                dictionaryInData[index] = "\(Sign.frontCurlyBracket)" + dictionaryInData[index] + "\(Sign.backCurlyBracket)"
            }
        }
        let dataReJoined = dictionaryInData.joined()
        dictionaryInData = dataReJoined.components(separatedBy: "\(Sign.pipe)")
        return dictionaryInData
    }
    /// [Json] 타입의 배열을 생성하는 함수
    func buildArray(inputData: String?) throws -> (json: [Json],dataMent: String) {
        var jsonData : [Json] = []
        var isolatedData : [String]
        let input = try distinctNil(input: inputData)
        let data = try distinctArray(inputData: input)
        let refinedData = isolatingString(input: data.input)
        if refinedData.contains(Sign.frontCurlyBracket), refinedData.contains(Sign.backCurlyBracket) {
            isolatedData = dictionaryInArray(input: refinedData).filter{ $0 != "" }
        } else {
            isolatedData = refinedData.components(separatedBy: "\(Sign.comma)").filter{ $0 != "" }
        }
        for dataElement in isolatedData {
            let refinedDatum = try valueOfArrayOrDistinct(dataElement: dataElement, dataMent: data.distinctMent)
            let jsonDatum = try parsingData(beforeData: refinedDatum)
            jsonData.append(jsonDatum)
        }
        return (json: jsonData, dataMent: data.distinctMent)
    }
 */
    private func parsingData(beforeData : String) throws -> Json {
        var convertedElement: Json
        var convertedDictionaryData = [String:Json]()
        let afterData = beforeData.trimmingCharacters(in: .whitespacesAndNewlines)
        if afterData.first == Sign.frontCurlyBracket, afterData.last == Sign.backCurlyBracket {
            var tokenizer = Tokenizer()
            let convertedData = tokenizer.buildDictionary(inputString: beforeData)
            for (key, value) in convertedData {
                convertedDictionaryData[key] = try parsingData(beforeData: value)
            }
            convertedElement = TypeDictionary.init(json: convertedDictionaryData)
        } else if let _ = Int(afterData) {
            convertedElement = TypeInt.init(json: afterData)
        } else if let _ = Bool(afterData) {
            convertedElement = TypeBool.init(json: afterData)
        } else if afterData.first == Sign.doubleQuote, afterData.last == Sign.doubleQuote {
            convertedElement = TypeString.init(json: afterData)
        } else {
            throw ErrorMessage.wrongValue
        }
        return convertedElement
    }
    
    func parsing(inputData: JsonParserable) throws -> (json: [Json],dataMent: String){
        var jsonData: [Json] = []
        if inputData.arrayJson != [], inputData.dictionaryJson.isEmpty {
            for element in inputData.arrayJson{
                let convertedElement = try parsingData(beforeData: element)
                jsonData.append(convertedElement)
            }
            return (json: jsonData, dataMent: DataMent.arrayMent.rawValue)
        } else if inputData.dictionaryJson.isEmpty == false, inputData.arrayJson == [] {
            
        }
        return (json: jsonData, dataMent: DataMent.arrayMent.rawValue)
    }
}
