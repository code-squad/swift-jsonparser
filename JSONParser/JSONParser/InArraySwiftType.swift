//
//  SwiftType.swift
//  JSONParser
//
//  Created by 윤동민 on 13/11/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

extension String : InArraySwiftType, InObjectSwiftType {}
extension Bool : InArraySwiftType, InObjectSwiftType {}
extension Int : InArraySwiftType, InObjectSwiftType {}
extension Dictionary : InArraySwiftType, JSONType {
    // 객체 안의 지원하는 타입의 개수를 각각 셈
    func countingType() -> (Int, Int, Int, Int, Int) {
        var typeCount : (total : Int, string : Int, number : Int, bool : Int, object : Int) = (self.count, 0, 0, 0, 0)
        for (_, value) in self {
            if value is String { typeCount.string += 1 }
            else if value is Bool { typeCount.bool += 1 }
            else { typeCount.number += 1 }
        }
        return typeCount
    }
}
extension Array : JSONType {
    // 배열 안의 지원하는 타입의 개수를 각각 셈
    func countingType() -> (Int, Int, Int, Int, Int) {
        var typeCount : (total : Int, string : Int, number : Int, bool : Int, object : Int) = (self.count, 0, 0, 0, 0)
        for eachData in self {
            if eachData is String { typeCount.string += 1 }
            else if eachData is Bool { typeCount.bool += 1 }
            else if eachData is Int { typeCount.number += 1 }
            else { typeCount.object += 1 }
        }
        return typeCount
    }
}

// 배열 안에 들어갈 수 있는 데이터 타입
protocol InArraySwiftType {
    
}
