//
//  JSONDataType.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol JSONValue {
    var typeDescription: String { get }
}

extension String: JSONValue {
    var typeDescription: String { return "문자열" }
}

extension Int: JSONValue {
    var typeDescription: String { return "숫자" }
}

extension Bool: JSONValue {
    var typeDescription: String { return "부울" }
}


