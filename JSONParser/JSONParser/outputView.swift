//
//  OutputView.swift
//  JSONParser
//
//  Created by 김장수 on 30/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private func printByType(_ counts: (string: Int, bool: Int, int: Int)) -> String {
        var string = String(), bool = String(), int = String()
        
        if counts.string > 0 { string = "문자열 \(counts.string)개" }
        if counts.int > 0 { bool = "숫자 \(counts.int)개" }
        if counts.bool > 0 { int = "부울 \(counts.bool)개 " }
        
        return [string, bool, int].joined(separator: ", ")
    }
    
    public func printResult(by counts: (string: Int, bool: Int, int: Int)) {
        let total = counts.string + counts.bool + counts.int
        let result = printByType(counts)
        
        print("총 \(total)개의 데이터 중에 \(result)포함되어 있습니다.")
    }
}
