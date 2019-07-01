//
//  OutputView.swift
//  JSONParser
//
//  Created by JieunKim on 06/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func printOut(_ input: JSONDataType) throws {
        if let jsonValue = input as? TypeCountable {
            printCountable(jsonValue.dataTypes)
        }
    }
    
    static func printJSON(_ input: JSONDataType) throws {
        if let json = input as? JSONSerializable {
            print(json.serialize())
        }
    }
    
    static func printCountable(_ dataTypes: [String: Int]) {
        let totalCount = dataTypes.values.reduce(0, +)
        var result = ""
        for (key, value) in dataTypes {
            result += "\(key)가 \(value)개 "
        }
        print("총 \(totalCount)개의 데이터 중에 \(result)포함되어 있습니다.")
    }
}
