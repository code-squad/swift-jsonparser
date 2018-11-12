//
//  OutputView.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    // 문자열, 부울, 숫자 각자의 갯수에 맞게 출력
    private func printByType(_ counts: (ints: [Int], bools: [Bool], strings: [String], totalCount: Int)) -> String {
        var result = String()
        
        if counts.strings.count > 0 { result += "문자열 \(counts.strings.count)개 " }
        if counts.ints.count > 0 { result += "숫자 \(counts.ints.count)개 " }
        if counts.bools.count > 0 { result += "부울 \(counts.bools.count)개 " }
        
        return "총 \(counts.totalCount)개의 데이터 중에 \(result)포함되어 있습니다."
    }
    
    // JSONParser에서 전달받은 데이터 세트를 출력
    public func printResult(by counts: JSONData) {
        let total = counts.getDTO()
        let result = printByType(total.json)
        
        print(result)
    }
}
