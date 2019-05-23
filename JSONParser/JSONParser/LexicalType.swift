//
//  LexicalType.swift
//  JSONParser
//
//  Created by hw on 23/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum LexicalType: CustomStringConvertible, CaseIterable {
    
    static var allCases : [LexicalType]{
        return [ .intNumber, .bool, .string, .jsonObject, .jsonArray]
    }
    
    case intNumber
    case bool
    case string
    case jsonObject
    case jsonArray
    
    var description: String {
        switch self {
        case .intNumber :
            return "숫자"
        case .string :
            return "문자열"
        case .bool :
            return "부울"
        case .jsonObject :
            return "객체"
        case .jsonArray :
            return "배열"
        }
    }
}
