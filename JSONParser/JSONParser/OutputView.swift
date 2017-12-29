//
//  OutputView.swift
//  JSONParser
//
//  Created by jack on 2017. 12. 19..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    enum Messages : String {
        case inputMessage = "분석할 JSON데이터를 입력하세요. 종료를 원하시면 q를 입력해주세요."
        case formatError = "지원하는 형식이 아닙니다. 다시 입력해주세요."
        case exitMessage = "종료합니다."
    }
    
    func printMessages(_ message : Messages) {
        print(message.rawValue)
    }
    
    func printResultOfData(_ countVal : MyCount) {
        let countOfData = makeNumberMessage(countVal)
        if countVal.currentData == "dictionary"  {
            print("총 \(countVal.objectVal)개의 객체 데이터 중에 \(countOfData)포함되어 있습니다.")
            return
        }
        let sumOfCount = countVal.boolVal + countVal.numberVal + countVal.boolVal + countVal.objectVal + countVal.arrayVal
        print("총 \(sumOfCount)개의 배열 데이터 중에 \(countOfData)포함되어 있습니다.")
    }
    
    private func makeNumberMessage(_ data : MyCount) -> String {
        var temp = ""
        if data.stringVal != 0 { temp += "문자열 \(data.stringVal)개 "}
        if data.numberVal != 0 { temp += "숫자 \(data.numberVal)개 "}
        if data.boolVal != 0 { temp += "부울 \(data.boolVal)개 "}
        if data.arrayVal != 0 { temp += "배열 \(data.arrayVal)개 "}
        if data.objectVal != 0 && data.currentData == "array" { temp += "객체 \(data.objectVal)개 "}
        return temp
    }
}
