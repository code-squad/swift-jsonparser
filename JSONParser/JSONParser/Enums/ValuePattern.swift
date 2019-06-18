//
//  Pattern.swift
//  JSONParser
//
//  Created by 이동영 on 18/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias Regex = String
enum
enum ValuePattern {
    case number
    case bool
    case string
    case ws
    case value
    case list
    
    var regex: Regex {
        switch self {
        case .number:
            return "[0-9]+"
        case .bool:
            return "true|false"
        case .string:
            return "\"[\\w\\s^\"]+\""
        case .ws:
            return "[\\s]*"
        case .value:
            return "\(ValuePattern.bool.regex)|\(ValuePattern.number.regex)|\(ValuePattern.string.regex)"
        case .list:
            return "\\[[\(ValuePattern.ws.regex)\(ValuePattern.value.regex)[,]?]+\\]"
        }
    }
}
