//
//  JsonObjectParsingStrategy.swift
//  JSONParser
//
//  Created by 이동영 on 31/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonObjectParsingStrategy: JsonParsingStrategy {
    typealias Indexs = Array<Int>
    private let converter: TokenConverter
    
    init(converter: TokenConverter) {
        self.converter = converter
    }
    
    func parse(tokens: inout Array<Token>) -> JsonValue {
        var isValue = true
        var keys = [String]() {
            didSet{
                isValue.toggle()
            }
        }
        var values = [JsonValue]() {
            didSet{
                isValue.toggle()
            }
        }
        tokens.removeFirst()
        
        while let token = tokens.first, token != .RightBrace {
            if isValue {
                switch token {
                case .LeftBrace,.LeftBraket:
                    let value = JsonParser().parse(tokens: &tokens)
                    values.append(value)
                default:
                    addValue(values: &values, token: token)
                    tokens.removeFirst()
                }
            }
            else{
                addKey(keys: &keys,token: token)
                tokens.removeFirst()
            }
        }
        
        let jsonObject = self.assemble(keyList: keys, valueList: values)
        return jsonObject
    }
    
    private func addKey(keys: inout Array<String>, token: Token) {
        if let key = self.converter.convert(before: token) {
            keys.append(key.getJsonValue())
        }
    }
    
    private func addValue(values: inout Array<JsonValue>, token: Token) {
        if let value = self.converter.convert(before: token) {
            values.append(value)
        }
    }
    
    private func assemble(keyList:Array<JsonValue>, valueList:Array<JsonValue>) -> JsonObject {
        var jsonObject = JsonObject()
        for (index,key) in keyList.enumerated() {
            jsonObject[key.getJsonValue()] = valueList[index]
        }
        return jsonObject
    }
}
