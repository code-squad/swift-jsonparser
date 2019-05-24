//
//  JSONObject.swift
//  JSONParser
//
//  Created by Daheen Lee on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONObject {
    private var keyValuePairs: [String : JSONValue]
    
    init() {
        keyValuePairs = [String : JSONValue]()
    }
    
    mutating func add(key: String, value: JSONValue) {
        keyValuePairs.updateValue(value, forKey: key)
    }
}

extension JSONObject: JSONValue {
    static var typeDescription: String {
        return "객체"
    }
}

extension JSONObject: TypeCountable {
    var elementCount: Int {
        return keyValuePairs.count
    }
}
