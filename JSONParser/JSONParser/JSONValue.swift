//
//  JSON.swift
//  JSONParser
//
//  Created by BLU on 2019. 6. 2..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

enum JSONValue: CustomStringConvertible {
    case string(String)
    case number(Int)
    case bool(Bool)
    
    var description: String {
        switch self {
        case .string(let string):
            return string
        case .number(let int):
            return String(int)
        case .bool(let bool):
            return String(bool)
        }
    }
}
