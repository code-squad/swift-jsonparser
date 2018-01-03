//
//  JSONData.swift
//  JSONParser
//
//  Created by YOUTH on 2017. 12. 11..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum JSONData {
    case IntegerValue(Int)
    case StringValue(String)
    case BoolValue(Bool)
    case ObjectValue(Dictionary<String, JSONData>)
    case ArrayValue([JSONData])
}

extension JSONData : CustomStringConvertible {
    var description: String {
        switch self {
        case .IntegerValue(let value):
            return String(value)
        case .StringValue(let value):
            return value
        case .BoolValue(let value):
            return String(value)
        case .ObjectValue(let value):
            return String(describing: value)
        case .ArrayValue(let value):
            return String(describing: value)
        }
    }
 }

