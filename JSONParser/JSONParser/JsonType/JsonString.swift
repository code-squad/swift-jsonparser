//
//  JsonString.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonString: JsonType {
    private let string : String
    
    init(string:String) {
        self.string = string.trimmingCharacters(in: ["\"","\""])
    }
    
    func type() -> TypeInfo {
        return .string
    }

    func JSONForm() -> String {
        return "\"\(string)\""
    }
}
