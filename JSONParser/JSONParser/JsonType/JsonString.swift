//
//  JsonString.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonString: JsonType {
    private let _data : String
    
    init(string:String) {
        self._data = string.trimmingCharacters(in: ["\"","\""])
    }
    
    func data() -> String {
        return self._data
    }
    
    func type() -> TypeInfo {
        return .string
    }
}
