//
//  JSONDataCount.swift
//  JSONParser
//
//  Created by JieunKim on 06/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONDataCount {
    static func JSONTypeCount(arrayData: [String]) throws -> (string: Int, number: Int, bool: Int) {
        let parsedInput = try arrayData.map {try JSONParser.parseValue(data: $0)}
        let stringCount = parsedInput.filter{$0 is String}.count
        let numberCount = parsedInput.filter{$0 is Number}.count
        let boolCount = parsedInput.filter{$0 is Bool}.count
        let result = (stringCount,numberCount,boolCount)
        return result
    }
    
}


