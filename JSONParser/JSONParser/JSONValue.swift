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
