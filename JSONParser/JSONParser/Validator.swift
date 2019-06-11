//
//  Validator.swift
//  JSONParser
//
//  Created by 이희찬 on 11/06/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct Validator {
    
    static func JSONArrayformat(input:String)throws -> String {
        guard input.hasPrefix(FormatItem.JSONArrayContainerLeft) && input.hasSuffix(FormatItem.JSONArrayContainerRight) else{
            throw InputError.InputError
        }
        return input
    }
    
}
