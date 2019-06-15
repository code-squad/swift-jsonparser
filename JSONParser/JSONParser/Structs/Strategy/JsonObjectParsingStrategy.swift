//
//  JsonObjectParsingStrategy.swift
//  JSONParser
//
//  Created by 이동영 on 31/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonObjectParsingStrategy: JsonParsingStrategy {
    typealias Key = String
    typealias Value = JsonValue
    private let converter: TokenConverter
    
    init(converter: TokenConverter) {
        self.converter = converter
    }
    
    func parse(tokens: inout [Token]) -> JsonValue {
        var keys = [Key]()
        var values = [Value]()
        var isValue : Bool {
            return keys.count > values.count
        }
        tokens.removeFirst()
        
        while let token = tokens.first , token != .RightBrace  {
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
            else {
                addKey(keys: &keys,token: token)
                tokens.removeFirst()
            }
        }
        return self.assemble(keys: keys, values: values)
    }
    
    private func addKey(keys: inout [Key], token: Token) {
        if let key = self.converter.convert(before: token) {
            keys.append(key.getJsonValue())
        }
    }
    
    private func addValue(values: inout [Value], token: Token) {
        if let value = self.converter.convert(before: token) {
            values.append(value)
        }
    }
    
    private func assemble(keys: [Key], values: [Value]) -> JsonObject {
    var jsonObject = JsonObject()
    for (index,key) in keys.enumerated() {
        jsonObject[key] = values[index]
    }
    return jsonObject
}
}
