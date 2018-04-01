//
//  ReulstView.swift
//  JSONParser
//
//  Created by rhino Q on 2018. 3. 30..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printResult(_ jsonData:JSONData ) {
        print("총 \(jsonData.paranet.count)개의 \(jsonData.paranet.name)데이터 중에", terminator:"")
        if jsonData.numberCount != 0 { print(" 숫자 \(jsonData.numberCount)개", terminator:"") }
        if jsonData.stringCount != 0 { print(" 문자열 \(jsonData.stringCount)개", terminator:"") }
        if jsonData.boolCount != 0 { print(" 부울 \(jsonData.boolCount)개", terminator: "") }
        if jsonData.objectCount != 0 { print(" 객체 \(jsonData.objectCount)개", terminator:"")}
        print("가 포함돼 있습니다.")
        print("-----------------------------------")
    }
}
