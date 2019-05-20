//
//  JSONArray.swift
//  JSONParser
//
//  Created by Daheen Lee on 20/05/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct JSONArray {
    private(set) var jsonValues: [JSONValue]
    
    var count: Int {
        return jsonValues.count
    }
    
    init() {
        self.jsonValues = []
    }
    
    mutating func append(_ newElement: JSONValue) {
        jsonValues.append(newElement)
    }
}

extension JSONArray: JSONValue {
    static var typeDescription: String {
        return "배열"
    }
}
