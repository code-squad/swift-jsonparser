//
//  JsonType.swift
//  JSONParser
//
//  Created by joon-ho kil on 4/29/19.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JsonType {
    case int(Int)
    case string(String)
    case bool(Bool)
    case object([String: JsonType])
    
    var koreanName: String {
        switch self {
        case .bool(_): return "부울"
        case .int(_): return "숫자"
        case .object(_): return "객체"
        case .string(_): return "문자열"
        }
    }
}

