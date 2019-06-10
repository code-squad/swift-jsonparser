//
//  JsonParser.swift
//  JSONParser
//
//  Created by jang gukjin on 02/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

extension String {
    func match(text: String) -> Bool {
        return self.range(of: text, options: .regularExpression)  != nil
    }
}

struct JsonParser {
    var arrayJsonData: [Json] = []
    var dictionaryJsonData = [String:Json]()
    
    /// [String:String] 형태의 딕셔너리를 [String:Json]으로 바꿔주는 함수
    private func convertDictionary(convertedData: [String:String]) throws -> [String:Json] {
        var convertedDictionaryData = [String:Json]()
        for (key, value) in convertedData {
            try GrammerChecker().distinctKeyType(key: key)
            convertedDictionaryData[key] = try parsingData(beforeData: value)
        }
        return convertedDictionaryData
    }
    
    /// 원소들을 조건에 따라 해당타입으로 파싱해주는 함수
    private func parsingData(beforeData : String) throws -> Json {
        var convertedElement: Json
        
        let afterData = beforeData.trimmingCharacters(in: .whitespacesAndNewlines)
        if afterData.match(text: RegularExpression.dictionaryType) {
            var tokenizer = Tokenizer()
            let convertedData = try tokenizer.buildDictionary(inputString: beforeData)
            convertedElement = try convertDictionary(convertedData: convertedData)
        } else if afterData.match(text: RegularExpression.arrayType) {
            var tokenizer = Tokenizer()
            convertedElement = try tokenizer.buildArray(inputString: beforeData)
        } else if afterData.match(text: RegularExpression.intType) {
            convertedElement = Int(afterData) ?? 0
        } else if afterData.match(text: RegularExpression.boolType) {
            convertedElement = Bool(afterData) ?? false
        } else if afterData.match(text: RegularExpression.stringType) {
            convertedElement = afterData.trimmingCharacters(in: CharacterSet(charactersIn: "\(Sign.doubleQuote)"))
        } else {
            throw ErrorMessage.wrongValue
        }
        return convertedElement
    }
    
    /// 배열이나 딕셔너리를 받아서 파싱하고 멘트를 반환하는 함수
    mutating func parsing(inputData: Tokenizer) throws -> String{
        if inputData.arrayJson != [], inputData.dictionaryJson.isEmpty {
            for element in inputData.arrayJson{
                let convertedElement = try parsingData(beforeData: element)
                arrayJsonData.append(convertedElement)
            }
            return DataMent.arrayMent.rawValue
        } else if inputData.dictionaryJson.isEmpty == false {
            for (key, value) in inputData.dictionaryJson{
                let convertedElement = try parsingData(beforeData: value)
                dictionaryJsonData[key] = convertedElement
            }
            return DataMent.dictionaryMent.rawValue
        } else {
            throw ErrorMessage.notArray
        }
    }
}
