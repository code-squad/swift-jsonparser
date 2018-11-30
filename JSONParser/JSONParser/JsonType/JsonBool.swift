//
//  JsonBool.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonBool: JsonType  {
    private let _data : Bool
    
    init(bool:String) {
        self._data = Bool(bool) ?? false
    }
    
    func data() -> Bool {
        return self._data
    }
    
    func type() -> TypeInfo {
        return .bool
    }
    
    func JSONForm() -> String {
        return "\(_data)"
    }
}
