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
    
    var name: JsonTypeName {
        switch self {
        case .bool(_): return JsonTypeName.bool
        case .int(_): return JsonTypeName.int
        case .object(_): return JsonTypeName.object
        case .string(_): return JsonTypeName.string
        }
    }
}

enum JsonTypeName: String {
    case int = "숫자"
    case string = "문자열"
    case bool = "부울"
    case object = "객체"
    case array = "배열"
    case total = "총"
    case nothing = ""
}
