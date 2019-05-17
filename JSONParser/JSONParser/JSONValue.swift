//
//  JSONValue.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum JSONValueType {
    case bool(Bool)
    case number(Int)
    case string(String)
}


protocol JSONValue {
    var type: JSONValueType { get }
}

extension Bool: JSONValue {
    var type: JSONValueType {
        return .bool(self)
    }
}

extension Int: JSONValue {
    var type: JSONValueType {
        return .number(self)
    }
}

extension String: JSONValue {
    var type: JSONValueType {
        return .string(self)
    }
}
