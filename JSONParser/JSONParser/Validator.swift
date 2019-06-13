//
//  Validator.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Validator {
    
    static func JSONFormatCheck(input:String)throws {
        if JSONIsArrayFormat(input: input) {
            <#code#>
        }
        guard JSONIsObjectFormat(input: input) else {
            throw InputError.InputError
        }
    }
    
    static func JSONIsArrayFormat(input:String) -> Bool {
        return input.hasPrefix(FormatItem.JSONArrayContainerLeft) && input.hasSuffix(FormatItem.JSONArrayContainerRight)
    }
    
    static func JSONIsObjectFormat(input:String) -> Bool {
        return input.hasPrefix(FormatItem.JSONObjectContainerLeft) && input.hasSuffix(FormatItem.JSONObjectContainerRight)
    }
    
}
