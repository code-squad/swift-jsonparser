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
    private var indexForNext: Int = 0
    private var jsonObject: Dictionary<String, Any>
    private var keys: Array<String>

    var count: Int {
        return keys.count
    }

    init() {
        jsonObject = [:]
        keys = []
    }

    mutating func next() -> (key: String, value: Any)? {
        if indexForNext == 0 {
            defer { indexForNext = count }
            return nil
        } else {
            let index = count-indexForNext
            defer { indexForNext -= 1 }
            return (key: keys[index], value: jsonObject[keys[index]] ?? "")
        }
    }

    mutating func add(key: String, value: Any) {
        jsonObject[key] = value
        countType(element: value)
        keys = [String](jsonObject.keys)
        indexForNext = count
    }

    private mutating func countType(element: Any) {
        if element is JSONObject || element is Dictionary<String, Any> {
            objectCounter += 1
        } else if element is JSONArray || element is Array<Any> {
            arrayCounter += 1
        } else if let stringElement = element as? String {
            if stringElement.count != 0 {
                stringCounter += 1
            }
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
