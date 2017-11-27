//
//  ResultView.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    enum Errors: String, Error {
        case emptyValue = "출력할 값이 없습니다."
    }
    
    typealias DataTypeName = JSONData.TypeName
    
    static func printResult(in data: JSONDataCountable & JSONDataMaker) {
        var description: String = ""
        let outputs = makeCharacterToOutput(in: data)
        
        description += "총 \(outputs[DataTypeName.array.rawValue] ?? 0)개의 데이터 중에 "
    
        for (type, count) in outputs.filter ({ (key, value) in key != "배열" && value > 0 }) {
            description += "\(type) \(count)개,"
        }
        
        description.removeLast()
        description += "가 포함되어 있습니다."
        
        print(description)
    }
    
    private static func makeCharacterToOutput(in data: JSONDataCountable & JSONDataMaker) -> [String: Int] {
        let jsonDataCount = data.arrayCount
        let booleanTypeCount = data.boolCount
        let numberTypeCount = data.numberCount
        let stringTypeCount = data.stringCount
        
        return [DataTypeName.array.rawValue: jsonDataCount, DataTypeName.bool.rawValue: booleanTypeCount, DataTypeName.number.rawValue: numberTypeCount, DataTypeName.string.rawValue: stringTypeCount]
    }
}

