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
        print("총 \(jsonData.sumOfData)개의 데이터 중에", terminator: "")
        printJSONData(jsonData)
        print("가 포함되어 있습니다.")
    }
    
    private func printJSONData(_ jsonData: JSONData) {
        if jsonData.stringTypeCount > 0 {
            print(" 문자열 \(jsonData.stringTypeCount)", terminator: "")
            if jsonData.intTypeCount > 0 || jsonData.boolTypeCount > 0 { print(",", terminator: "") }
        }
        if jsonData.intTypeCount > 0 {
            print(" 숫자 \(jsonData.intTypeCount)", terminator: "")
            if jsonData.stringTypeCount > 0 || jsonData.boolTypeCount > 0 { print(",", terminator: "") }
        }
        if jsonData.boolTypeCount > 0 {
            print(" 부울 \(jsonData.boolTypeCount)", terminator: "")
        }
    }
}
