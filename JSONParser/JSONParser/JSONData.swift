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
    var string: [String]?
    var number: [Number]?
    var bool: [Bool]?
}

extension JSONData {
    init?(parsedData: [Any]) {
        for each in parsedData {
            switch each {
            case is Number: self.number?.append(each as! Number)
            case is String: self.string?.append(each as! String)
            case is Bool: self.bool?.append(each as! Bool)
            default: break
            }
        }
    }
    
    static func parse(from rawData: String) -> [Any] {
        return []
    }
}


