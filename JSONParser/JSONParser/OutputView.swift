//
//  OutputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    func printResult (_ data : [Any]) {
        let countOfObjects = countNumberOfObjects(userData: data)
        print("총 \(data.count)개의 데이터 중에 \(countOfObjects) 포함되어 있습니다.")
    }
    
    private func makeNumberMessage(_ data : (stringVal : Int, numberVal : Int, boolVal : Int)) -> String {
        var temp = ""
        if data.stringVal != 0 { temp += "문자열 \(data.stringVal)개 "}
        if data.numberVal != 0 { temp += "숫자 \(data.numberVal)개 "}
        if data.boolVal != 0 { temp += "부울 \(data.boolVal)개 "}
        return temp
    }
    
    private func countNumberOfObjects(userData : [Any]) -> String {
        var temp : (stringVal : Int, numberVal : Int, boolVal : Int) = (0,0,0)
        for oneData in userData {
            switch oneData {
            case is String : temp.stringVal += 1
            case is Int : temp.numberVal += 1
            case is Bool : temp.boolVal += 1
            default : break
            }
        }
        return makeNumberMessage(temp)
    }
}
