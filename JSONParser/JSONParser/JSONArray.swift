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

extension JSONArray: TypeCountable {
    var elementCount: Int {
        return jsonValues.count
    }
}
