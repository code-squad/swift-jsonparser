//
//  DataTypesSupportedByJSON.swift
//  JSONParser
//
//  Created by 이동영 on 11/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum RegularExpressionPatterns: String {
    case String = "\"[\\w]+\""
    case Integer = "[\\d]+"
    case Boolean = "(true|false)"
    case Array = "^\\[|\\]$"
    
}
