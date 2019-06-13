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
    var printArray = [String]()
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
    
    /// [String] 형태의 배열을 [Json]으로 바꿔주는 함수
    private func convertArray(convertedData: [String]) throws -> [Json] {
        var convertedArrayData = [Json]()
        for index in 0..<convertedData.count {
            convertedArrayData.append(try parsingData(beforeData: convertedData[index]))
        }
        return convertedArrayData
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
            let convertedData = try tokenizer.buildArray(inputString: beforeData)
            convertedElement = try convertArray(convertedData: convertedData)
        } else if afterData.match(text: RegularExpression.intType) {
            convertedElement = Int(afterData) ?? 0
        } else if afterData.match(text: RegularExpression.boolType) {
            convertedElement = Bool(afterData) ?? false
        } else if afterData.match(text: RegularExpression.stringType) {
            convertedElement = afterData//.trimmingCharacters(in: CharacterSet(charactersIn: "\(Sign.doubleQuote)"))
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
    
    /// Json 데이터가 배열인지 딕셔너리인지 판단하여 출력하는 배열로 변환하는 함수
    mutating func convertToPrint(jsonData: JsonParser, dataMent: String) -> [String] {
        if dataMent == "배열" {
            printArray.append("\(Sign.frontSquareBracket)")
            for index in 0..<jsonData.arrayJsonData.count {
                arrayConvertToPrint(jsonData: jsonData.arrayJsonData, index: index)
            }
            printArray.append("\(Sign.backSquareBracket)")
            return printArray
        } else {
            printArray.append("\(Sign.frontCurlyBracket)")
            for (key, value) in jsonData.dictionaryJsonData{
                dictionaryConvertToPrint(jsonData: jsonData.dictionaryJsonData, key: key, value: value)
            }
            printArray[printArray.endIndex-1].removeLast()
            printArray.append("\(Sign.backCurlyBracket)")
            return printArray
        }
    }
    
    /// 배열 Json 데이터를 한줄씩 출력하는 배열로 변환하는 함수
    private mutating func arrayConvertToPrint(jsonData: [Json], index: Int) {//-> [String]{
        switch jsonData[index]{
        case is Dictionary<String,Json>:
            printArray.append("\(Sign.frontCurlyBracket)")
            for (key, value) in jsonData[index] as! Dictionary<String,Json>{
                printArray.append(" \(key)\(Sign.colon)\(value)\(Sign.comma)")
            }
            printArray[printArray.endIndex-1].removeLast()
            printArray.append("\(Sign.backCurlyBracket)\(Sign.comma)")
        case is Array<Json>:
            var array = [String]()
            for value in jsonData[index] as! Array<Json>{
                array.append("\(value)")
            }
            printArray.append("\(Sign.frontSquareBracket)"+array.joined(separator: "\(Sign.comma)")+"\(Sign.backSquareBracket)\(Sign.comma)")
        default:
            printArray.append("\(jsonData[index])\(Sign.comma)")
        }
        if index == jsonData.endIndex-1 {
            printArray[printArray.endIndex-1].removeLast()
        }
    }
    
    /// 딕셔너리 Json 데이터를 한줄씩 출력하는 배열로 변환하는 함수
    private mutating func dictionaryConvertToPrint(jsonData: [String:Json], key: String, value: Json) {//-> [String]{
        switch value{
        case is Dictionary<String,Json>:
            printArray.append("\(key)\(Sign.colon)\(Sign.frontCurlyBracket)")
            for (keyInValue, valueInValue) in value as! Dictionary<String,Json>{
                printArray.append(" \(keyInValue)\(Sign.colon)\(valueInValue)\(Sign.comma)")
            }
            printArray[printArray.endIndex-1].removeLast()
            printArray.append("\(Sign.backCurlyBracket)\(Sign.comma)")
        case is Array<Json>:
            var array = [String]()
            for valueInValue in value as! Array<Json>{
                array.append("\(valueInValue)")
            }
            printArray.append(" \(key)\(Sign.colon)\(Sign.frontSquareBracket)"+array.joined(separator: "\(Sign.comma)")+"\(Sign.backSquareBracket)\(Sign.comma)")
        default:
            printArray.append(" \(key)\(Sign.colon)\(value)\(Sign.comma)")
        }
    }
}
