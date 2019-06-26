//
//  OutputView.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printPrettyJSON(_ jsonValue: JSONValue) {
        var writer = Writer { str in
            print(str, terminator: "")
        }
        writer.serializeJSON(jsonValue)
        print("\n", terminator: "")
    }
    
    static func printJSONValue(_ jsonValue: JSONValue) {
        if let json = jsonValue as? JSONValue & TypeCountable {
            printDataType(json)
        }
    }
    
    private static func printDataType(_ json: JSONValue & TypeCountable) {
        let type = json.typeDescription
        let totalCount = json.dataTypes.values.reduce(0, +)
        let containTypes = json.dataTypes.map { "\($0) \($1)개" }.joined(separator: ",")
        let description: (Int, String, String) -> String = { (count: Int, type: String, containTypes: String) in
            return "총 \(count)개의 \(type) 데이터 중에 \(containTypes)가 포함되어 있습니다."
        }
        print(description(totalCount, type, containTypes))
    }
}
