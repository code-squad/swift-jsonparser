//
//  JsonBool.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonBool: JsonType  {
    private let bool : Bool
    
    init(bool:String) {
        self.bool = Bool(bool) ?? false
    }
    
    func type() -> TypeInfo {
        return .bool
    }
    
    func JSONForm() -> String {
        return "\(bool)"
    }
}
