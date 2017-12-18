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
        print ("총 \(input.total)개의 데이터중 객체 \(input.ofObject) 숫자 \(input.ofNumericValue)개, 불값 \(input.ofBooleanValue)개, 문자열 \(input.ofStringValue)개가 있습니다.")
    }
}
