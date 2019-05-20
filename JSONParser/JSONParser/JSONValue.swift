//
//  JSONValue.swift
//  JSONParser
//
//  Created by Daheen Lee on 17/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONValue {
    static var typeDescription: String { get }
}

extension Bool: JSONValue {
    static var typeDescription: String { return "부울" }
}

extension Int: JSONValue {
    static var typeDescription: String { return "숫자" }
}

extension String: JSONValue {
    static var typeDescription: String { return "문자열" }
}

extension Array: JSONValue where Element: JSONValue {
    static var typeDescription: String {
        return "배열"
    }
}

