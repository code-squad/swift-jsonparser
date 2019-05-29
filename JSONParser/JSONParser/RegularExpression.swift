//
//  RegularExpression.swift
//  JSONParser
//
//  Created by jang gukjin on 29/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct RegularExpression {
    static let arrayType:String = "^\\[.+\\]$"
    static let dictionaryType:String = "^\\{.+\\}$"
    static let stringType:String = "^\".+\"$"
    static let intType:String = "[0-9]"
    static let boolType:String = "true|false"
}
