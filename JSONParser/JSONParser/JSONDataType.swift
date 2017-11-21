//
//  CaseJSONDataType.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataType {
    private var typeDictionary: [String: Int]
    
    init() {
        self.typeDictionary = [:]
    }
    
    init(booleanTypeCount: Int, numberTypeCount: Int, stringTypeCount: Int) {
        self.typeDictionary = [TypeName.boolean.rawValue: booleanTypeCount, TypeName.number.rawValue: numberTypeCount, TypeName.string.rawValue: stringTypeCount]
    }
    
    subscript(key: String) -> Int {
        return typeDictionary[key] ?? 0
    }
    
    enum TypeName: String {
        case boolean = "부울"
        case number = "숫자"
        case string = "문자열"
        case array = "배열"
    }
}


