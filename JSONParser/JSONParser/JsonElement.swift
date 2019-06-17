//
//  TokenElement.swift
//  JSONParser
//
//  Created by 이진영 on 30/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JsonElement {
    static let doubleQuotion: Character = "\""
    static let comma: Character = ","
    static let whitespace: Character = " "
    static let startOfArray: Character = "["
    static let endOfArray: Character = "]"
    static let startOfObject: Character = "{"
    static let endOfObject: Character = "}"
    
    static let `true` = "true"
    static let `false` = "false"
    
    static let baseToken = [comma, whitespace, startOfArray, endOfArray, startOfObject, endOfObject]
    
    static let supportType = [startOfArray, endOfArray, startOfObject, endOfObject]
    
    static func pair(value: Character?) -> Character? {
        switch value {
        case doubleQuotion:
            return doubleQuotion
        case startOfObject:
            return endOfObject
        case startOfArray:
            return endOfArray
        default:
            return nil
        }
    }
}
