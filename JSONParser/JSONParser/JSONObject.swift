//
//  JSONObject.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONObject: JSONType {
    private(set) var JSONData: Array<String>
    private(set) var JSONObject: Dictionary<String, Any>

    init() {
        self.JSONData = []
        self.JSONObject = [:]
    }

    mutating func add(keyValue: (key: String, value: Any)) {
        JSONData.append(keyValue.key)
        JSONObject[keyValue.key] = keyValue.value
    }
    
}
