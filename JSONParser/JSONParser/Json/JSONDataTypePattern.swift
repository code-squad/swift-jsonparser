//
//  CaseJSONDataTypePattern.swift
//  JSONParser
//
//  Created by yuaming on 2017. 11. 21..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

enum JSONDataTypePattern: String {
    case bool = "^true|false|null"
    case number = "^[0-9]+"
    case string = "^[A-Za-z0-9가-힣-+\"]+"
}
