//
//  ResultView.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {    
    private typealias DataTypeName = JSONData.TypeName
    
    static func printResult(in data: JSONDataCountable & JSONDataMaker) {
        printJSONData(in: JSONDataGenerator.unwrapJSONData(in: data.makeJSONData(), indent: 0))
        printJSONDataType(in: data)
    }
    
    private static func printJSONData(in data: String) {
        print(data)
    }
    
    private static func printJSONDataType(in data: JSONDataCountable) {
        var description: String = ""
        let outputs = makeCharacterToOutput(in: data)
        let label = searchArrayOrObjectWords(in: data)
        
        description += "\(DataTypeName.total.rawValue) \(outputs[DataTypeName.total.rawValue] ?? 0)개의 \(label) 데이터 중에 "
        
        description += outputs.filter({ (key, value) in key != DataTypeName.total.rawValue && value > 0 }).map{ (type, count) in
            "\(type) \(count)개,"
            }.joined()
        
        description.removeLast()
        description += "가 포함되어 있습니다."
        
        print(description)
    }
    
    private static func searchArrayOrObjectWords(in data: JSONDataCountable) -> String {
        return data is JSONArray ? DataTypeName.array.rawValue : DataTypeName.object.rawValue
    }
    
    private static func makeCharacterToOutput(in data: JSONDataCountable) -> [String: Int] {
        let arrayCount = data.arrayCount
        let objectCount = data.objectCount
        let booleanTypeCount = data.boolCount
        let numberTypeCount = data.numberCount
        let stringTypeCount = data.stringCount
        let totalCount = data.totalCount
        
        return [DataTypeName.array.rawValue: arrayCount, DataTypeName.object.rawValue: objectCount,
                DataTypeName.bool.rawValue: booleanTypeCount, DataTypeName.number.rawValue: numberTypeCount, DataTypeName.string.rawValue: stringTypeCount, DataTypeName.total.rawValue: totalCount]
    }
}

