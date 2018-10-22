//
//  File.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct TypeInspector {
    static func countType(of jsonArray: [Any?]) -> [String: Int] {
        var typeCount: [String: Int] = [:]
        let defaultValue = 0
        let count = 1
        for value in jsonArray {
            switch value {
            case is String:
                typeCount["문자열"] = (typeCount["문자열"] ?? defaultValue) + count
            case is Int:
                typeCount["숫자"] = (typeCount["숫자"] ?? defaultValue) + count
            case is Bool:
                typeCount["부울"] = (typeCount["부울"] ?? defaultValue) + count
            default:
                typeCount["nil"] = (typeCount["nil"] ?? defaultValue) + count
            }
        }
        return typeCount
    }
}

