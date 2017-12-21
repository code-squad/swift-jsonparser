//
//  OutputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    func printResultOfData(_ countVal : MyData) {
        let countOfData = makeNumberMessage(countVal)
        if countVal is MyDictionary {
            print("총 \(countVal.objectVal)개의 객체 데이터 중에 \(countOfData)포함되어 있습니다.")
            return
        }
        let sumOfCount = countVal.boolVal + countVal.numberVal + countVal.boolVal + countVal.objectVal
        print("총 \(sumOfCount)개의 배열 데이터 중에 \(countOfData)포함되어 있습니다.")

    }
    
    private func makeNumberMessage(_ data : MyData) -> String {
        var temp = ""
        if data.stringVal != 0 { temp += "문자열 \(data.stringVal)개 "}
        if data.numberVal != 0 { temp += "숫자 \(data.numberVal)개 "}
        if data.boolVal != 0 { temp += "부울 \(data.boolVal)개 "}
        if data.objectVal != 0 && data is MyArray { temp += "객체 \(data.objectVal)개 "}
        return temp
        
    }
}
