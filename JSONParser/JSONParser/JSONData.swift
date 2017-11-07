//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    typealias Number = Int
    var string: [String]
    var number: [Number]
    var bool: [Bool]
    var count: Int {
        return self.number.count + self.string.count + self.bool.count
    }
}
