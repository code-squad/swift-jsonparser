//
//  jsonParser.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    let leftSquare:Character = "[", rightSquare:Character = "]"
    
    // 문자열의 배열을 각 데이터 형태에 프로토콜로 리턴
    func parse(from input: String) -> JSONData {
        let rawData = input.removeBracket.separateByComma
        
        guard input.first == leftSquare && input.last == rightSquare else {
            return parseObject(of: rawData)
        }
        
        return parseArray(of: rawData)
    }
    
    private func parseArray(of input: [String]) -> JSONData {
        var ints = [Int]()
        var bools = [Bool]()
        var strings = [String]()
        
        input.forEach {
            if $0.isNumeric { ints.append(Int($0)!) }
            if $0.isBoolean { bools.append(Bool($0)!) }
            if $0.isString { strings.append($0) }
        }
        
        return SwiftJSON(ints: ints, bools: bools, strings: strings)
    }
    
    private func parseObject(of input: [String]) -> JSONData {
        var ints = [Int]()
        var bools = [Bool]()
        var strings = [String]()

        input.forEach {
            let temp = $0.separateByColumn.last!
            if temp.isNumeric { ints.append(Int(temp)!) }
            if temp.isBoolean { bools.append(Bool(temp)!) }
            if temp.isString { strings.append(temp) }
        }
        
        return SwiftJSON(ints: ints, bools: bools, strings: strings)
    }
}
