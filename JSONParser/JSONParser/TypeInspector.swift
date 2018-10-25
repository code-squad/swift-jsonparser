//
//  File.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

public enum typeName: String {
    case string = "문자열"
    case int = "숫자"
    case bool = "부울"
    case object = "객체"
    case array = "배열"
    case none = ""
}

struct TypeInspector {
    static func countType(of jsonValues: [JSONValue]) -> [String: Int] {
        var typeCount: [String: Int] = [:]
        let defaultValue = 0
        let count = 1
        for value in jsonValues {
            switch value {
            case .string:
                typeCount[typeName.string.rawValue] = (typeCount[typeName.string.rawValue] ?? defaultValue) + count
            case .int:
                typeCount[typeName.int.rawValue] = (typeCount[typeName.int.rawValue] ?? defaultValue) + count
            case .bool:
                typeCount[typeName.bool.rawValue] = (typeCount[typeName.bool.rawValue] ?? defaultValue) + count
            case .object:
                typeCount[typeName.object.rawValue] = (typeCount[typeName.object.rawValue] ?? defaultValue) + count
            default:
                continue
            }
        }
        return typeCount
    }
}

