//
//  OutputView.swift
//  JSONParser
//
//  Created by JieunKim on 06/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation


struct OutputView {
    static func printDescription(input: [JSONDataType]) throws {
        let description = try printDataCount(arrayData: input)
        print(description)
    }
    
    static private func printDataCount(arrayData: [JSONDataType]) throws -> String {
        var result: String = ""
        let totalCount = arrayData.count
        let counts = try JSONDataCount.JSONTypeCount(arrayData: arrayData)
        for (key, value) in counts {
            result += "\(key)이 \(value)개 "
        }
        return "총 \(totalCount)개의 데이터 중에 \(result)포함되어 있습니다."
    }
}
