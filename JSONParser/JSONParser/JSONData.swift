//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    enum Number {
        case UInt
        case Int
        case Float
        case Double
    }
    var string: [String]
    var number: [Number]
    var bool: [Bool]
}

extension JSONData {
    init?(data: String) {
        
    }
    
    static func parse(from stringData: String) -> [Any] {
        
    }
}
