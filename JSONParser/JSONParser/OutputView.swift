//
//  OutputView.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func showTypeCountOf(JSON stringArray: [String]) {
        let totalCount = stringArray.count
        let stringCout = StringInspector.countType(in: stringArray)
        let doubleCount = DoubleInspector.countType(in: stringArray)
        let boolCount = BooleanInspector.countType(in: stringArray)
        print("총 \(totalCount)개의 데이터 중에 문자열 \(stringCout)개, 숫자 \(doubleCount)개, 부울 \(boolCount)개가 포함되어 있습니다.")
    }
}
