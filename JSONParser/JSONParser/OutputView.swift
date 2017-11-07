//
//  OutputView.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printDataReport(of data: JSONData) {
        var result = "총 \(data.count)개의 데이터 중에"
        if data.string.count > 0 {
            result += " 문자열 \(data.string.count)개,"
        }
        if data.number.count > 0 {
            result += " 숫자 \(data.number.count)개,"
        }
        if data.bool.count > 0 {
            result += " 부울 \(data.bool.count)개,"
        }
        result.removeLast()
        result += "가 포함되어 있습니다."
        print(result)
    }
    
}
