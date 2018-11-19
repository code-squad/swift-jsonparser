//
//  JsonString.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonString: ArrayUsableType, ObjectUsableType {
    private let string : String
    
    init(string:String) {
        self.string = string
    }
    
}
