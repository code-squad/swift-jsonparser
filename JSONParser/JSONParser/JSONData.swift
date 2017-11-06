//
//  JSONData.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 2..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    
    private(set) var array: [Value]
    
    init(array: [Value]) {
        self.array = array
    }
}

