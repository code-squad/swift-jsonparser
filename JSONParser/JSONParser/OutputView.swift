//
//  OutputView.swift
//  JSONParser
//
//  Created by JINA on 07/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private static let totalDataStr = { (splitInput:[String]) -> String in return "총 \(splitInput.count)개의 데이터 중에" }
    private static let included = "가 포함되어 있습니다."
    
    static func printData(in JSON: JSONData, from splitInput: [String]) {
        let typeBoolean = JSON.typeBoolean > 0 && JSON.typeString == 0 && JSON.typeNumber == 0
        let typeString = JSON.typeBoolean == 0 && JSON.typeString > 0 && JSON.typeNumber == 0
        let typeNumber = JSON.typeBoolean == 0 && JSON.typeString == 0 && JSON.typeNumber > 0
        
        switch (typeBoolean,typeString,typeNumber) {
        case (true, _, _):
            print("\(totalDataStr(splitInput)) 부울 \(JSON.typeBoolean)개\(included)")
        case (_, true, _):
            print("\(totalDataStr(splitInput)) 문자열 \(JSON.typeString)개\(included)")
        case (_, _, true):
            print("\(totalDataStr(splitInput)) 숫자 \(JSON.typeNumber)개\(included)")
        default:
            printDatas(in: JSON, from: splitInput)
        }
        print("")
    }
   
    private static func printDatas(in JSON: JSONData, from splitInput: [String]) {
        var datas = ""
        for (key,value) in JSON.data {
            if value != 0 {
                datas.append("\(key) \(value)개, ")
            }
        }
        print("\(totalDataStr(splitInput)) \(datas.dropLast(2))\(included)")
    }
    
}
