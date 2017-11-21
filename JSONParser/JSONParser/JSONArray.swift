//
//  JSONArray.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 20..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONArray: JSONType, Sequence, IteratorProtocol {
    private(set) var stringCounter: Int = 0
    private(set) var intCounter: Int = 0
    private(set) var boolCounter: Int = 0
    private(set) var objectCounter: Int = 0
    private(set) var arrayCounter: Int = 0
    private(set) var container: String = "배열"
    private var jsonArray: Array<Any>
    private var indexForNext: Int = 0

    var count: Int {
        return jsonArray.count
    }

    init() {
        self.jsonArray = []
    }

    mutating func next() -> Any? {
        if indexForNext == 0 {
            defer { indexForNext = count }
            return nil
        } else {
            defer { indexForNext -= 1 }
            return jsonArray[count-indexForNext]
        }
    }

    mutating func add(element: Any) {
        jsonArray.append(element)
        countType(element: element)
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

    subscript(_ index: Int) -> Any {
        return jsonArray[index]
    }

}
