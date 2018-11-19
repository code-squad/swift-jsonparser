//
//  JsonNumber.swift
//  JSONParser
//
//  Created by 조재흥 on 18. 11. 19..
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JsonNumber: ArrayUsableType, ObjectUsableType {
    private let number : Double
    
    init(number:Double) {
        self.number = number
    }
    
}
