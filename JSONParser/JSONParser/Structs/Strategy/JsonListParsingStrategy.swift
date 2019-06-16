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
    
    func parse(tokens: [Token], parsedIndex: Int = 0) -> ParsedResult {
        var jsonList = JsonList()
        var parsedIndex = parsedIndex+1
        var ing: Bool {
            return tokens.count > parsedIndex
        }
        
        while ing {
            let token = tokens[parsedIndex]
            switch token {
            case .LeftBrace,.LeftBraket:
                let result = JsonParser().run(tokens: tokens, parsedIndex: parsedIndex)
                parsedIndex = result.parsedIndex
                jsonList.append(result.value)
            case .RightBraket:
                return (jsonList,parsedIndex+1)
            default:
                if let value = converter.convert(before: token) {
                    jsonList.append(value)
                }
                parsedIndex+=1
            }
            
        }
        return (jsonList,parsedIndex)
    }
}
