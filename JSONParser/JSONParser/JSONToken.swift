//
//  JSONToken.swift
//  JSONParser
//
//  Created by JieunKim on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

public enum JSON {
    case dictionary([String: JSON])
    case array([JSON])
    case int(Int)
    case string(String)
    case bool(Bool)
}

extension JSON {
    var valueDescription: String {
        switch self {
        case .dictionary: return "Object"
        case .array:
            return "Array"
        case .int(let int):
            return String(int)
        case .string(let string):
            return "\"\(string)\""
        case .bool(let bool):
            return String(bool)
        }
    }
}
