//
//  OutputView.swift
//  JSONParser
//
//  Created by Eunjin Kim on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {

    func printDataInfo(data: DataInfo) {
        let sum = data.countOfBool + data.countOfNumber + data.countOfString + data.countOfObject + data.countOfArray
        var result = [String]()
        print("총 \(sum)개의 \("") 데이터 중에", terminator: "")
        if data.countOfString != 0 {
            result.append(" 문자열 \(data.countOfString)개")
        }
        if data.countOfNumber != 0 {
            result.append(" 숫자 \(data.countOfNumber)개")
        }
        if data.countOfBool != 0 {
            result.append(" 부울 \(data.countOfBool)개")
        }
        if data.countOfObject != 0 {
            result.append(" 객체 \(data.countOfObject)개")
        }
        if data.countOfArray != 0 {
            result.append(" 배열 \(data.countOfArray)개")
        }
        print(result.joined(separator: ","), terminator: "")
        print("가 포함되어 있습니다.")
    }
    
    func printJsonString(jsonData: JSONParsingData) {
        print(jsonData.printParsingData(intent: 0))
    }
    
}
