//
//  OutputView.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    // 총 4개의 객체 데이터 중에 문자열 2개, 숫자 1개, 부울 1개가 포함되어 있습니다.
    // 총 2개의 배열 데이터 중에 객체 2개가 포함되어 있습니다.
    static func printJSONData(_ jsonData: JSONPrintable) {
        print("\(jsonData.totalDataCountDescription())\(jsonData.countDataDescription())가 포함되어 있습니다.")
    }
}
