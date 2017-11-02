//
//  JSONObject.swift
//  JSONParser
//
//  Created by yangpc on 2017. 10. 30..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

typealias value = Any

struct JSONObject {
    
    private(set) var dictionary: [String:value]
    
    init(dictionary: [String:value]) {
        self.dictionary = dictionary
    }
}

