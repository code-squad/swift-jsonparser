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
    
    func parse(tokens: [Token], parsedIndex: Int = 0) -> ParsedResult {
        var keys = [Key]()
        var values = [Value]()
        var parsedIndex = parsedIndex+1
        var ing: Bool {
            return tokens.count > parsedIndex
        }
        var isValue: Bool {
            return keys.count > values.count
        }
        var jsonObject: JsonObject {
            return self.assemble(keys: keys, values: values)
        }
        
        while ing {
            let token = tokens[parsedIndex]
            switch token {
            case .leftBraket,.leftBrace:
                let result = JsonParser.run(tokens: tokens, parsedIndex: parsedIndex)
                parsedIndex = result.parsedIndex
                values.append(result.value)
            case .rightBrace:
                return (jsonObject, parsedIndex+1)
            default:
                if let value = converter.convert(before: token) {
                    isValue ? values.append(value) : keys.append(value.getJsonValue())
                }
                parsedIndex+=1
            }
        }
        return (jsonObject, parsedIndex+1)
    }
    
    private func assemble(keys: [Key], values: [Value]) -> JsonObject {
        var jsonObject = JsonObject()
        for (index,key) in keys.enumerated() {
            jsonObject[key] = values[index]
        }
        return jsonObject
    }
}
