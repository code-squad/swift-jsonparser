//
//  ResultView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultView {
    
    func countNumber(_ data: [String:Any]) -> String {
        var count = 0
        for type in data.values {
            if type is Int {
                count += 1
            }
        }
        return "숫자 \(count) 개"
    }
    
    func countString(_ data: [String:Any]) -> String {
        var count = 0
        for type in data.values {
            if type is String {
                count += 1
            }
        }
        return "문자 \(count) 개"
    }
    
    func countBool(_ data: [String:Any]) -> String {
        var count = 0
        for type in data.values {
            if type is Bool {
                count += 1
            }
        }
        return "부울 \(count) 개"
    }
    
    func resultDicionaryMessage(_ data: [String:Any]) {
        let dataCount = data.count
        let number = countNumber(data)
        let string = countString(data)
        let bool = countBool(data)
        if !number.contains("0") && !string.contains("0") && !bool.contains("0") {
            print("총 \(dataCount)개의 객체 데이터 중에 \(number), \(string), \(bool)가 포함되어 있습니다")
        } else if !number.contains("0") && !string.contains("0") {
            print("총 \(dataCount)개의 객체 데이터 중에 \(number), \(string)가 포함되어 있습니다")
        } else if !number.contains("0") && !bool.contains("0") {
            print("총 \(dataCount)개의 객체 데이터 중에 \(number), \(bool)가 포함되어 있습니다")
        } else if !string.contains("0") && !bool.contains("0") {
            print("총 \(dataCount)개의 객체 데이터 중에 \(string), \(bool)가 포함되어 있습니다")
        } else if !number.contains("0") {
            print("총 \(dataCount)개의 객체 데이터 중에 \(number)가 포함되어 있습니다")
        } else if !string.contains("0") {
            print("총 \(dataCount)개의 객체 데이터 중에 \(string)가 포함되어 있습니다")
        } else if !bool.contains("0") {
            print("총 \(dataCount)개의 객체 데이터 중에 \(bool)가 포함되어 있습니다")
        }
    }
    
    func resultArrayMessage(_ data: [String]) {
        print("총 \(data.count)개의 배열 데이터 중에 객체 \(data.count)개 가 포함되어 있습니다.")
    }

}
