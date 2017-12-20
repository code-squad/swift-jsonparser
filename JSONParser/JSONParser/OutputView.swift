//
//  OutputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    func printResult (_ countVal : (stringVal : Int, numberVal : Int, boolVal : Int)) {
        let sumOfCount = countVal.boolVal + countVal.numberVal + countVal.stringVal
        let countOfObjects = makeNumberMessage(countVal)
        print("총 \(sumOfCount)개의 데이터 중에 \(countOfObjects)포함되어 있습니다.")
    }
    
    private func makeNumberMessage(_ data : (stringVal : Int, numberVal : Int, boolVal : Int)) -> String {
        var temp = ""
        if data.stringVal != 0 { temp += "문자열 \(data.stringVal)개 "}
        if data.numberVal != 0 { temp += "숫자 \(data.numberVal)개 "}
        if data.boolVal != 0 { temp += "부울 \(data.boolVal)개 "}
        return temp
    }
}
