//
//  JSONObject.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

typealias Value = Any

// Value Types: Array, Object, String, Number, Bool
struct JSONObject {
    
    private(set) var dictionary: [String : Value]
    
    init(dictionary: [String : Value]) {
        self.dictionary = dictionary
    }
}

