//
//  JsonDictionary.swift
//  JSONParser
//
//  Created by hw on 09/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonArray {
    private (set) var orderedJsonElementPairs: [LexPair]
    
    private (set) var jsonIntElements: [String]
    private (set) var jsonStringElements: [String]
    private (set) var jsonBoolElements: [String]
    
    init (lexPair : [LexPair]){
        orderedJsonElementPairs = lexPair
        
        self.jsonIntElements = [String]()
        self.jsonStringElements = [String]()
        self.jsonBoolElements = [String]()
        
        for element in lexPair {
            switch element.type {
            case LexicalType.intNumber:
                jsonIntElements.append(element.content)
            case LexicalType.bool:
                jsonBoolElements.append(element.content)
            case LexicalType.string:
                jsonStringElements.append(element.content)
            }
        }
    }
}

