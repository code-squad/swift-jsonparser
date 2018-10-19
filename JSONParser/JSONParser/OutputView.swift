//
//  OutputView.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct OutputView {
    private static func countType(in stringArray: [String]) -> [Int] {
        var typeCount = [Int]()
        typeCount.append(StringInspector.countType(in: stringArray))
        typeCount.append(DoubleInspector.countType(in: stringArray))
        typeCount.append(BooleanInspector.countType(in: stringArray))
        return typeCount
    }
    
    private static func addTypeName(in stringArray: [String]) -> String {
        var typeName: [String?] = ["문자열", "숫자", "부울"]
        let typeCount = countType(in: stringArray)
        for index in 0..<3 {
            if (typeCount[index]==0) {
                typeName[index] = nil
                continue
            }
            typeName[index]?.append(" \(typeCount[index])개")
        }
        return typeName.compactMap({$0}).joined(separator: ", ")
    }
    
    static func showTypeCountOf(JSON stringArray: [String]) {
        let totalCount = stringArray.count
        let typeCount = addTypeName(in: stringArray)
        print("총 \(totalCount)개의 데이터 중에 \(typeCount)가 포함되어 있습니다.")
    }
}
