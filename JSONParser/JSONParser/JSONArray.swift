//
//  JSONArray.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONType {
    private(set) var JSONData: Array<String>
    private(set) var JSONArray: Array<Any>

    init() {
        self.JSONData = []
        self.JSONArray = []
    }

    mutating func add(element: Any) {
        JSONArray.append(element)
        JSONData.append(String(describing: element))
    }
}
