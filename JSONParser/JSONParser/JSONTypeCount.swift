//
//  JSONTypeCount.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 7..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

typealias NumberOfType = (jsonObject:Int, string:Int, int:Int, bool:Int, array:Int)

struct JSONTypeCount {
    private(set) var dictionary: [String:Int]
    init() {
        dictionary = [ "객체":0, "문자열":0, "숫자":0, "부울":0, "배열":0 ]
    }
    mutating func calculateNumberOfType(_ count: NumberOfType) {
        dictionary["객체"] = count.jsonObject
        dictionary["문자열"] = count.string
        dictionary["숫자"] = count.int
        dictionary["부울"] = count.bool
        dictionary["배열"] = count.array
    }
}
