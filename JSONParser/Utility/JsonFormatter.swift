//
//  JsonFormatter.swift
//  JSONParser
//
//  Created by hw on 10/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonFormatter{
    
    private var jsonData : JsonParsable
    private (set) var countDictionary: [LexicalType: Int]
    private (set) var totalCount = 0
    private (set) var descendingOrderByValueCountInformation : [(key: LexicalType, value: Int)] = [(key:LexicalType, value: Int)]()
    
    init(jsonData: JsonParsable) throws {
        self.jsonData = jsonData
        countDictionary = [LexicalType: Int]()
        try countDataTypeOfElementInJsonData()
        self.descendingOrderByValueCountInformation = self.countDictionary.sorted { $0.value > $1.value }
    }
    
    mutating private func initiateCountDictionary () {
        for element in LexicalType.allCases {
            self.countDictionary.updateValue(0, forKey: element)
        }
    }
    
    mutating func countDataTypeOfElementInJsonData() throws {
        let jsonLexicalType = try Lexer.confirmTokenDataType(jsonData.description)
        switch jsonLexicalType {
        case .jsonArray :
            try countElementTypeInJsonArray()
        case .jsonObject:
            try countElementTypeInJsonObject()
        default:
            throw ErrorCode.lexicalTypeError
        }
    }
    
    private mutating func checkElementDataType(_ element : JsonParsable) {
        self.totalCount += 1
        switch element{
        case is Bool:
            let currentCount = countDictionary[LexicalType.bool] ?? 0
            countDictionary[LexicalType.bool] = currentCount + 1
        case is Int:
            let currentCount = countDictionary[LexicalType.intNumber] ?? 0
            countDictionary[LexicalType.intNumber] = currentCount + 1
        case is JsonObject:
            let currentCount = countDictionary[LexicalType.jsonObject] ?? 0
            countDictionary[LexicalType.jsonObject] = currentCount + 1
        case is JsonArray:
            let currentCount = countDictionary[LexicalType.jsonArray] ?? 0
            countDictionary[LexicalType.jsonArray] = currentCount + 1
        case is String :
            let currentCount = countDictionary[LexicalType.string] ?? 0
            countDictionary[LexicalType.string] = currentCount + 1
        default:
            break
        }
    }
    
    private mutating func countElementTypeInJsonObject() throws {
        guard let jsonObject: JsonObject = self.jsonData as? JsonObject else{
            throw ErrorCode.convertJsonObjectError
        }
        for (_, element) in jsonObject.keyValueSet.enumerated() {
            checkElementDataType(element.value)
        }
    }
    
    private mutating func countElementTypeInJsonArray() throws {
        guard let jsonArray: JsonArray = self.jsonData as? JsonArray else{
            throw ErrorCode.convertJsonArrayError
        }
        for element in jsonArray.arrayList {
            checkElementDataType(element)
        }
    }
    
}
