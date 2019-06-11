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
    private let converter = TokenConverter()
    
    func parse(tokens: [Token]) -> JsonValue {
        var tokens = tokens.filter {
            return !["\"",","," "].contains($0.getValue())
        }
        var jsonObject = JsonObject()
        var (keyTokenIndexs,valueTokenIndexs) = separate(tokens: tokens)
        let propertyCount = keyTokenIndexs.count
        
        for index in 0..<propertyCount {
            guard let key = converter.convert(before: tokens[keyTokenIndexs[index]]) else {
                continue
            }
            let value = self.converter.convert(before: tokens[valueTokenIndexs[index]])
            jsonObject[key as! String] = value
        }
        return jsonObject
    }

    private func separate(tokens: Array<Token>) -> (Indexs,Indexs) {
        var keyTokenIndexs = Array<Int>()
        var valueTokenIndexs = Array<Int>()
        
        for (index,token) in tokens.enumerated() {
            if token == .Colon{
                keyTokenIndexs.append(index-1)
                valueTokenIndexs.append(index+1)
            }
        }
        return (keyTokenIndexs,valueTokenIndexs)
    }
}
