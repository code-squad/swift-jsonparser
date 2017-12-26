//
//  OutputView.swift
//  JSONParser
//
//  Created by Choi Jeong Hoon on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation
struct OutputView {
    static func printResult (_ countedValue: JsonData) {
        if countedValue.type == JsonData.CountingType.object {
            print ("총 \(countedValue.total)개의 객체중 숫자 \(countedValue.ofNumericValue)개, 불값 \(countedValue.ofBooleanValue)개, 문자열 \(countedValue.ofStringValue)개, 배열 \(countedValue.ofArray)개가 있습니다.")
        } else if countedValue.type == JsonData.CountingType.array {
            print ("총 \(countedValue.total)개의 배열 데이터중 객체 \(countedValue.ofObject) 숫자 \(countedValue.ofNumericValue)개, 불값 \(countedValue.ofBooleanValue)개, 문자열 \(countedValue.ofStringValue)개, 배열 \(countedValue.ofArray)개가 있습니다.")
        }
    }
}
