//
//  OutputView.swift
//  JSONParser
//
//  Created by hw on 09/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static private let unit = "개"
    static func printJsonInformation (_ format : JsonFormatter){
        var result = "총 \(format.totalCount)개의 데이터 중에"
        let descendingOrderDictionary = format.descendingOrderByValueCountInformation
        for element in descendingOrderDictionary {
            if element.value == 0 {
                continue
            }
            result += " \(element.key) \(element.value)\(unit),"
        }
        result.removeLast()
        result += "가 포함되어 있습니다."
        print(result)
    }
}
