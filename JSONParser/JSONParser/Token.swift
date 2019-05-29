//
//  Token.swift
//  JSONParser
//
//  Created by BLU on 2019. 5. 29..
//  Copyright © 2019년 JK. All rights reserved.
//

import Foundation

enum Token {
    case doubleQuotation
    case comma
    case bool(Bool)
    case string(String)
    case number(Int)
}
