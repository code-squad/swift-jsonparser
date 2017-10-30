//
//  OutputView.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printAnalyzeResult(_ jsonArray: JSONObject) {
        let countOfStrings = jsonArray.stringObjects.count
        let countOfIntegers = jsonArray.intObjects.count
        let countOfBools = jsonArray.boolObjects.count
        print("총 \(countOfStrings+countOfIntegers+countOfBools) 개의 데이터 중에", terminator: "")
        if countOfStrings != 0 { print(" 문자열 \(countOfStrings) 개", terminator: "") }
        if countOfIntegers != 0 { print(" 숫자 \(countOfIntegers) 개", terminator: "") }
        if countOfBools != 0 { print(" 부울 \(countOfBools) 개", terminator: "") }
        print("가 포함되어 있습니다.")
    }
}
