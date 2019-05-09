//
//  Validation.swift
//  JSONParser
//
//  Created by hw on 07/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Validation {
    
    static func checkInvalidArrayFormat (_ input : String) throws  {
        var isValid: Bool = true
        isValid &= checkStartSquareBracket(input)
        isValid &= checkEndSquareBracket(input)
        if !isValid{
            throw ErrorCode.invalidJsonFormat
        }
    }
   
    static private func checkStartSquareBracket(_ input: String) -> Bool {
        return input[input.startIndex] == "[" ? true : false
    }
    
    static private func checkEndSquareBracket(_ input: String) -> Bool {
        return input[input.index(before: input.endIndex)] == "]" ? true : false
    }
}


extension Bool {
    static func &= (lhs: inout Bool, rhs: Bool) {
        lhs = lhs && rhs
    }
}

