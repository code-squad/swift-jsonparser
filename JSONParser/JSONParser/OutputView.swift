//
//  OutputView.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
struct OutputView {
    static func printResult (_ input: CountingData) {
         print ("총 \(input.countOfTotalValue)의 데이터중 숫자 \(input.countOfNumericValue.count)개, 불값 \(input.countOfBooleanValue.count)개, 문자열 \(input.countOfStringValue.count)개가 있습니다.")
    }
}
