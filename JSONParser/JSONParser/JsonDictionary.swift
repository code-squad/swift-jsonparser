//
//  JsonDictionary.swift
//  JSONParser
//
//  Created by hw on 09/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonDictionary {
    private var jsonElements : [LexicalType : [String]] = [LexicalType.intNumber : [String](), LexicalType.bool :  [String](), LexicalType.string : [String]()]
    
    init (lexPair : [LexPair]){
        for element in lexPair{
            self.jsonElements[element.type]?.append(element.content)
        }
    }
    var intCount : Int {
        get {
            return jsonElements[LexicalType.intNumber]?.count ?? 0
        }
    }
    var stringCount : Int {
        get {
            return jsonElements[LexicalType.string]?.count ?? 0
        }
    }
    var boolCount : Int {
        get{
            return jsonElements[LexicalType.bool]?.count ?? 0
        }
    }
    var totalCount : Int {
        get {
            return boolCount + stringCount + intCount
        }
    }
}
    
