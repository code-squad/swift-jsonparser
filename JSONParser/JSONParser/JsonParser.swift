//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonParser {
    var arrayJsonData: [Json] = []
    var dictionaryJsonData = [String:Json]()
    /// 원소들을 조건에 따라 해당타입으로 파싱해주는 함수
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
    
    private func distinctKeyType(key: String) throws {
        if key.first != "\"" || key.last != "\"" {
            throw ErrorMessage.wrongKey
        }
    }
    /// 배열이나 딕셔너리를 받아서 파싱하고 멘트를 반환하는 함수
    mutating func parsing(inputData: JsonParserable) throws -> String{
        if inputData.arrayJson != [], inputData.dictionaryJson.isEmpty {
            for element in inputData.arrayJson{
                let convertedElement = try parsingData(beforeData: element)
                arrayJsonData.append(convertedElement)
            }
            return DataMent.arrayMent.rawValue
        } else if inputData.dictionaryJson.isEmpty == false {
            for (key, value) in inputData.dictionaryJson{
                try distinctKeyType(key: key)
                let convertedElement = try parsingData(beforeData: value)
                dictionaryJsonData[key] = convertedElement
            }
            return DataMent.dictionaryMent.rawValue
        } else {
            throw ErrorMessage.notArray
        }
    }
}
