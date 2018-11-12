//
//  jsonParser.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    // 문자열의 배열을 각 데이터 형태에 프로토콜(SwiftArray)로 리턴
    public func parse(from input: String) -> JSONData {
        var ints = [Int]()
        var bools = [Bool]()
        var strings = [String]()
        
        let rawData = input.removeBracket.separateByComma
        rawData.forEach {
            if $0.isNumeric { ints.append(Int($0) ?? 0) }
            if $0.isBoolean { bools.append(Bool($0) ?? false) }
            if $0.isString { strings.append($0) }
        }
        
        return SwiftJSON(ints: ints, bools: bools, strings: strings)
    }
}
