//
//  ResultView.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printResult(in data: JSONArray) {
        var description: String = ""
        let outputs = makeCharacterToOutput(in: data)
        
        description += "총 \(outputs["총"]!)개의 데이터 중에 "
    
        for (type, count) in outputs.filter ({ (key, value) in key != "총" && value > 0 }) {
            description += "\(type) \(count)개,"
        }
        
        description.removeLast()
        description += "가 포함되어 있습니다."
        
        print(description)
    }
    
    private static func makeCharacterToOutput(in data: JSONArray) -> [String: Int] {
        let jsonDataCount = data.jsonArray.count
        let booleanTypeCount = data.jsonDataType.booleanTypeCount
        let numberTypeCount = data.jsonDataType.numberTypeCount
        let stringTypeCount = data.jsonDataType.stringTypeCount
        
        return ["총": jsonDataCount, "부울": booleanTypeCount, "숫자": numberTypeCount, "문자": stringTypeCount]
    }
}
