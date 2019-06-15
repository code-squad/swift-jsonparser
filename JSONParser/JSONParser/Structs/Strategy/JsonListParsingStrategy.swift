//
//  JsonListParsingStrategy.swift
//  JSONParser
//
//  Created by 이동영 on 31/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonListParsingStrategy: JsonParsingStrategy {
    private let converter: TokenConverter
    
    init(converter: TokenConverter) {
        self.converter = converter
    }
    
    func parse(tokens: inout Array<Token>) -> JsonValue {
        var jsonList = JsonList()
        tokens.removeFirst()
        
        while let token = tokens.first {
            switch token {
            case .LeftBraket,.LeftBrace:
                let result = JsonParser().parse(tokens: &tokens)
                jsonList.append(result)
            case .RightBraket:
                tokens.removeFirst()
                return jsonList
            default:
                if let jsonValue = self.converter.convert(before: token) {
                    jsonList.append(jsonValue)
                }
                tokens.removeFirst()
            }
        }
        return jsonList
    }
}
