//
//  ResultView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultView {
    
    func isEmptyNumber(_ number: [Int]) -> String {
        guard number.isEmpty else { return "숫자 \(number.count)개" }
        return ""
    }
    
    func isEmptyString(_ string: [String]) -> String {
        guard string.isEmpty else { return "문자열 \(string.count)개" }
        return ""
    }
    
    func isEmptyBool(_ bool: [Bool]) -> String {
        guard bool.isEmpty else { return "부울 \(bool.count)개" }
        return ""
    }
    
    func resultMessage(_ numberArray: [Int],_ stringArray: [String],_ boolArray: [Bool],_ data: [String]) {
        let number = isEmptyNumber(numberArray)
        let string = isEmptyString(stringArray)
        let bool = isEmptyBool(boolArray)
        if !numberArray.isEmpty && !stringArray.isEmpty && !boolArray.isEmpty {
            print("총 \(data.count)개의 데이터 중에 \(number), \(string), \(bool)가 포함되어 있습니다")
        } else if !numberArray.isEmpty && !stringArray.isEmpty {
            print("총 \(data.count)개의 데이터 중에 \(number), \(string)가 포함되어 있습니다")
        } else if !numberArray.isEmpty && !boolArray.isEmpty {
            print("총 \(data.count)개의 데이터 중에 \(number), \(bool)가 포함되어 있습니다")
        } else if !stringArray.isEmpty && !boolArray.isEmpty {
            print("총 \(data.count)개의 데이터 중에 \(string), \(bool)가 포함되어 있습니다")
        } else if numberArray.isEmpty && stringArray.isEmpty && boolArray.isEmpty {
            print("")
        } else {
            print("총 \(data.count)개의 데이터 중에 \(number)\(string)\(bool)가 포함되어 있습니다")
        }
    }
    
}
