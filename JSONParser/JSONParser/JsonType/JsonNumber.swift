//
//  JsonNumber.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonNumber: JsonType {
    private let number : Double
    
    init(number:String) {
        self.number = Double(number) ?? 0
    }
    
    func type() -> TypeInfo {
        return .number
    }
    
    func JSONForm() -> String {
        return "\(Int(number))"
    }
}
