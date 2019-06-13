//
//  Validator.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Validator {
    
    static func JSONIsArrayFormat(input:String) -> Bool {
        return input.hasPrefix(FormatItem.JSONArrayContainerLeft) && input.hasSuffix(FormatItem.JSONArrayContainerRight)
    }
    
    static func JSONIsObjectFormat(input:String)throws -> Bool {
        let isObjectFormat = input.hasPrefix(FormatItem.JSONObjectContainerLeft) && input.hasSuffix(FormatItem.JSONObjectContainerRight)
        guard isObjectFormat else {
            throw InputError.InputError
        }
        return isObjectFormat
    }
}
