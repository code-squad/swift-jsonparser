//
//  ReulstView.swift
//  JSONParser
//
//  Created by rhino Q on 2018. 3. 30..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    static func printResult(_ stringCount:Int, _ boolCount : Int, _ numberCount: Int ) {
        print("총 \(stringCount + boolCount + numberCount)개의 데이터 중에 ", terminator:"")
        if numberCount != 0 { print("숫자 \(numberCount)개 ", terminator:"") }
        if stringCount != 0 { print("문자열 \(stringCount)개 ", terminator:"") }
        if boolCount != 0 { print("부울 \(boolCount)개 ", terminator: "") }
        print("가 포함돼 있습니다.")
        print("-----------------------------------")
    }
}
