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
        if input is Array<JSONDataType> {
            let description = try printDataCount(arrayData: input)
            print(description)
        } else {
            print(input)
        }
    }
    
    static private func printDataCount(arrayData: JSONDataType) throws -> String {
        var result: String = ""
        guard let array = arrayData as? Array<JSONDataType> else {
            throw JSONError.emptyBuffer
        }
        
        let totalCount = array.count
        let counts = try Counter.count(jsonData: array)
        for (key, value) in counts {
            result += "\(key)가 \(value)개 "
        }
        return "총 \(totalCount)개의 데이터 중에 \(result)포함되어 있습니다."
    }
}

