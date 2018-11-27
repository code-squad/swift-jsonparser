//
//  SwiftType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String : InSetJSONType {}
extension Bool : InSetJSONType  {}
extension Int : InSetJSONType {}
extension Dictionary : InSetJSONType, JSONType {
    // 객체 안의 지원하는 타입의 개수를 각각 셈
    func matchTypeForCounting() -> (Int, Int, Int, Int, Int, Int) {
        var valueSet : [InSetJSONType] = []
        for (_, value) in self { valueSet.append(value as! InSetJSONType) }
        return countType(allData: valueSet)
    }
    
    // 객체 프린트 문구 리턴
    func printTotalText(_ totalCount: Int) -> String {
        return "총 \(totalCount)개의 객체 데이터 중에 "
    }
}

extension Array : InSetJSONType, JSONType {
    // 배열 안의 지원하는 타입의 개수를 각각 셈
    func matchTypeForCounting() -> (Int, Int, Int, Int, Int, Int) {
        return countType(allData: self as! [InSetJSONType])
    }
    
    // 배열 프린트 문구 리턴
    func printTotalText(_ totalCount: Int) -> String {
        return "총 \(totalCount)개의 배열 데이터 중에 "
    }
}

// 배열 안에 들어갈 수 있는 데이터 타입
protocol InSetJSONType {}
