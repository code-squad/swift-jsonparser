//
//  OutputView.swift
//  JSONParser
//
//  Created by JH on 22/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct OutputView {
    
    func show(string: String) {
        print(string)
    }
    
    func showCount(typeName: String, countInfo: [String: Int]) {
        let valueCountList = countInfo.values // 값들의 갯수 배열
        let sumOfValueCounts = valueCountList.reduce(0) { (result: Int, value: Int) -> Int in
            return result + value
        }
        let countInfo = countInfo.map { "\($0.key) \($0.value)개" }
        let output = countInfo.joined(separator: ", ")
        
        print("총 \(sumOfValueCounts)개의 \(typeName)데이터 중에 \(output)가 포함되어 있습니다.")

    }
}
