//
//  JsonDictionary.swift
//  JSONParser
//
//  Created by hw on 09/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonDictionary {
    
    private (set) var jsonIntElements: [String] = [String]()
    private (set) var jsonStringElements: [String] = [String]()
    private (set) var jsonBoolElements: [String] = [String]()
    
    init (lexPair : [LexPair]){
        for element in lexPair{
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
    
