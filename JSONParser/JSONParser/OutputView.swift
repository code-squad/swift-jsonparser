//
//  OutputView.swift
//  JSONParser
//
//  Created by 이동건 on 06/08/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    static func display(json: [String], strings: [String], integers: [Int], booleans: [Bool]) {
        print("총 \(json.count)개의 데이터 중에 문자열 \(strings.count)개, 숫자 \(integers.count)개, 부울 \(booleans.count)개가 포함되어 있습니다.")
    }
}
