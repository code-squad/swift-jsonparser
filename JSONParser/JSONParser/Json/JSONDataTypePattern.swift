//
//  CaseJSONDataTypePattern.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONDataTypePattern {
    static let bool: String = "^true|false|null"
    static let number: String = "^[0-9]+"
    static let string: String = "^[A-Za-z0-9가-힣-+\"]+"
}
