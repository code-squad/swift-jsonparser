//
//  JsonBool.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonBool: ArrayUsableType, ObjectUsableType  {
    private let bool : Bool
    
    init(bool:Bool) {
        self.bool = bool
    }
    
}
