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
        let numberOfData = jsonData.boolTypeCount +
                            jsonData.intTypeCount +
                            jsonData.stringTypeCount
        print("총 \(numberOfData)개의 데이터 중에", terminator: "")
        
        for _ in 0..<numberOfData {
            if jsonData.stringTypeCount > 0 {
                print(" 문자열 \(jsonData.stringTypeCount)")
            } else if jsonData.intTypeCount > 0 {
                print(" 숫자 \(jsonData.intTypeCount)")
            } else if jsonData.boolTypeCount > 0 {
                print(" 부울 \(jsonData.boolTypeCount)")
            }
            if numberOfData > 0 { print(",") }
        }
        print("가 포함되어 있습니다.")
    }
}
