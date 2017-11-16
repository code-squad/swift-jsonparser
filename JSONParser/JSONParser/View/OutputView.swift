//
//  OutputView.swift
//  JSONParser
//
//  Created by Mrlee on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    func printJSONAnalysis(jsonData: JSONData) {
        if jsonData.jsonArray.count > 0 {
            print("총 \(jsonData.sumOfData)개의 배열 데이터 중에", terminator: "")
        } else if jsonData.jsonObject.count > 0 {
            print("총 \(jsonData.sumOfData)개의 객체 데이터 중에", terminator: "")
        }
        printJSONData(jsonData)
        print("가 포함되어 있습니다.")
    }
    
    func printErrorMsg(errorCode: ErrorCode) {
        switch errorCode {
        case .invalidJSONStandard:
            print("JSON규격에 맞지않습니다. 올바른 입력값을 넣어주세요 :)")
        case .invalidInputString:
            print("입력값을 확인해주세요 :)")
        }
    }
    
    private func printJSONData(_ jsonData: JSONData) {
        if jsonData.stringTypeCount > 0 {
            print(" 문자열 \(jsonData.stringTypeCount)개", terminator: "")
            if jsonData.sumOfData != jsonData.stringTypeCount { print(",", terminator: "") }
        }
        if jsonData.intTypeCount > 0 {
            print(" 숫자 \(jsonData.intTypeCount)개", terminator: "")
            if jsonData.sumOfData != jsonData.intTypeCount { print(",", terminator: "") }
        }
        if jsonData.boolTypeCount > 0 {
            print(" 부울 \(jsonData.boolTypeCount)개", terminator: "")
            if jsonData.sumOfData != jsonData.boolTypeCount { print(",", terminator: "") }
        }
        if jsonData.objectTypeCount > 0 {
            print(" 객체 \(jsonData.objectTypeCount)개", terminator: "")
        }
    }
}
