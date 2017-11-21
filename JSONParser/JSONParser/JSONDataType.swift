//
//  CaseJSONDataType.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataType {
    private(set) var booleanTypeCount: Int = 0
    private(set) var numberTypeCount: Int = 0
    private(set) var stringTypeCount: Int = 0
    
    init(){}
    
    init(booleanTypeCount: Int, numberTypeCount: Int, stringTypeCount: Int) {
        self.booleanTypeCount = booleanTypeCount
        self.numberTypeCount = numberTypeCount
        self.stringTypeCount = stringTypeCount
    }
}


