//
//  JSONType.swift
//  JSONParser
//
//  Created by 윤지영 on 23/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

enum JSONValue {
    case string(String)
    case int(Int)
    case bool(Bool)
    case object(JSONObject)
    case array(JSONArray)

    var typeName: String {
        switch self {
        case .string:
            return "문자열"
        case .int:
            return "숫자"
        case .bool:
            return "부울"
        case .object:
            return "객체"
        case .array:
            return "배열"
        }
    }
}
