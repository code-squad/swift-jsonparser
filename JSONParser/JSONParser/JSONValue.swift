//
//  JSONValue.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONValue {
    var typeDescription: String { get }
    func formatted(indentLevel: Int) -> String
}

extension Bool: JSONValue {
    var typeDescription: String { return "부울" }
}

extension Int: JSONValue {
    var typeDescription: String { return "숫자" }
}

extension String: JSONValue {
    var typeDescription: String { return "문자열" }
}

extension Array: JSONValue where Element == JSONValue {
    var typeDescription: String { return "배열" }
}

extension Dictionary: JSONValue where Key == String, Value == JSONValue {
    var typeDescription: String { return "객체" }
}
