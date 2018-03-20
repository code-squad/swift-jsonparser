//
//  ResultView.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 13..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct ResultView {
    
    func countNumber(_ number: [String:Int]) -> String {
        guard number.values.isEmpty else { return "숫자 \(number.values.count)"}
        return ""
    }
    
    func countString(_ string: [String:String]) -> String {
        guard string.values.isEmpty else { return "문자 \(string.values.count)"}
        return ""
    }
    
    func countBool(_ bool: [String:Bool]) -> String {
        guard bool.values.isEmpty else { return "부울 \(bool.values.count)"}
        return ""
    }
    
    func resultDicionaryMessage(_ numberData: [String:Int],_ stringData: [String:String],_ boolData: [String:Bool]) {
        let data = numberData.count + stringData.count + boolData.count
        let number = countNumber(numberData)
        let string = countString(stringData)
        let bool = countBool(boolData)
        if !numberData.isEmpty && !stringData.isEmpty && !boolData.isEmpty {
            print("총 \(data)개의 객체 데이터 중에 \(number), \(string), \(bool)가 포함되어 있습니다")
        } else if !numberData.isEmpty && !stringData.isEmpty {
            print("총 \(data)개의 객체 데이터 중에 \(number), \(string)가 포함되어 있습니다")
        } else if !numberData.isEmpty && !boolData.isEmpty {
            print("총 \(data)개의 객체 데이터 중에 \(number), \(bool)가 포함되어 있습니다")
        } else if !stringData.isEmpty && !boolData.isEmpty {
            print("총 \(data)개의 객체 데이터 중에 \(string), \(bool)가 포함되어 있습니다")
        } else if numberData.isEmpty && stringData.isEmpty && boolData.isEmpty {
            print("")
        } else {
            print("총 \(data)개의 객체 데이터 중에 \(number)\(string)\(bool)가 포함되어 있습니다")
        }
    }
    
    func resultArrayMessage(_ data: [String]) {
        print("총 \(data.count)개의 배열 데이터 중에 객체 \(data.count)가 포함되어 있습니다.")
    }

}

