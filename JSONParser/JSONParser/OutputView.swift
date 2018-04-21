//
//  OutputView.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printJSONData(_ jsonData: JSONPrintable) {
        
        let totalDataType: TotalDataType = jsonData.totalDataType()
        var result = "총 \(jsonData.total())개의 \(totalDataType.rawValue) 데이터 중에 "
        switch totalDataType {
        case .list:
            result += jsonData.countObjectDescription()
        case .object:
            result += jsonData.countValueDescription()
        }
        result.removeLast()
        result += "가 포함되어 있습니다."
        print(result)
    }
}
