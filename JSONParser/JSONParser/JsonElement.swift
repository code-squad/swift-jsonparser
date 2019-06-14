//
//  TokenElement.swift
//  JSONParser
//
//  Created by 이진영 on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonElement {
    static let string: Character = "\""
    static let comma: Character = ","
    static let whitespace: Character = " "
    static let startOfArray: Character = "["
    static let endOfArray: Character = "]"
    static let startOfObject: Character = "{"
    static let endOfObject: Character = "}"
    
    static let `true` = "true"
    static let `false` = "false"
    
    static let arrayToken = [comma, whitespace, startOfArray, endOfArray]
    
    static let supportedType = [startOfArray, endOfArray, startOfObject, endOfObject]
}
