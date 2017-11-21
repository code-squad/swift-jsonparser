//
//  JSONObject.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONObject: JSONType, Sequence, IteratorProtocol {
    private(set) var stringCounter : Int = 0
    private(set) var intCounter : Int = 0
    private(set) var boolCounter : Int = 0
    private(set) var objectCounter : Int = 0
    private(set) var arrayCounter : Int = 0
    private(set) var container : String = "객체"
    private(set) var count: Int = 0
    private(set) var keyCount: Int = 0
    private var jsonObject: Dictionary<String, Any>
    private var keys: Array<String>

    init() {
        jsonObject = [:]
        keys = []
    }

    mutating func next() -> (key: String, value: Any)? {
        if keyCount == 0 {
            return nil
        } else {
            let index = count-keyCount
            defer { keyCount -= 1 }
            return (key: keys[index], value: jsonObject[keys[index]] ?? "")
        }
    }

    mutating func add(key: String, value: Any) {
        jsonObject[key] = value
        countType(element: value)
        count += 1
        keys = [String](jsonObject.keys)
        keyCount += 1
    }

    private mutating func countType(element: Any) {
        if element is JSONObject || element is Dictionary<String, Any> {
            objectCounter += 1
        } else if element is JSONArray || element is Array<Any> {
            arrayCounter += 1
        } else if element is String && (element as! String).count != 0 {
            stringCounter += 1
        } else if element is Int {
            intCounter += 1
        } else if element is Bool {
            boolCounter += 1
        }
    }

    subscript(_ key: String) -> Any? {
        return jsonObject[key]
    }

}
