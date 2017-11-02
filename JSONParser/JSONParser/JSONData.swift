//
//  JSONData.swift
//  JSONParser
//
//  Created by yangpc on 2017. 11. 2..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    
    private(set) var array: [Value]?
    private(set) var object: JSONObject?
    
    var isArray: Bool {
        return self.array == nil ? false : true
    }
    
    init(array: [Value]) {
        self.array = array
        self.object = nil
    }
    
    init(object: JSONObject) {
        self.array = nil
        self.object = object
    }
}

