//
//  ResultView.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    typealias DataTypeName = JSONDataType.TypeName
    
    static func printResult(in data: JSONArray) {
        var description: String = ""
        let outputs = makeCharacterToOutput(in: data)
        
        description += "총 \(outputs[DataTypeName.array.rawValue]!)개의 데이터 중에 "
    
        for (type, count) in outputs.filter ({ (key, value) in key != "배열" && value > 0 }) {
            description += "\(type) \(count)개,"
        }
        
        description.removeLast()
        description += "가 포함되어 있습니다."
        
        print(description)
    }
    
    private static func makeCharacterToOutput(in data: JSONArray) -> [String: Int] {
        let jsonDataCount = data.count
        let booleanTypeCount = data.getJSONDataType[DataTypeName.boolean.rawValue]
        let numberTypeCount = data.getJSONDataType[DataTypeName.number.rawValue]
        let stringTypeCount = data.getJSONDataType[DataTypeName.string.rawValue]
        
        return [DataTypeName.array.rawValue: jsonDataCount, DataTypeName.boolean.rawValue: booleanTypeCount, DataTypeName.number.rawValue: numberTypeCount, DataTypeName.string.rawValue: stringTypeCount]
    }
}
