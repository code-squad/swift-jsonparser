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
}

enum JsonTypeName: String {
    case total = "총"
    case int = "숫자"
    case stirng = "문자열"
    case bool = "부울"
    case object = "객체"
    case array = "배열"
    case nothing = ""
}
