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
    private(set) var count: Int = 0
    private var jsonArray: Array<Any>
    private var currentCount: Int = 0

    init() {
        self.jsonArray = []
    }

    mutating func next() -> Any? {
        if currentCount == 0 {
            return nil
        } else {
            defer { currentCount -= 1 }
            return jsonArray[count-currentCount]
        }
    }

    mutating func add(element: Any) {
        jsonArray.append(element)
        countType(element: element)
        count += 1
        currentCount += 1
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
