//
//  TypeCounter.swift
//  JSONParser
//
//  Created by TaeHyeonLee on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct TypeCounter {
    private(set) var stringCounter : Int = 0
    private(set) var intCounter : Int = 0
    private(set) var boolCounter : Int = 0
    private(set) var objectCounter : Int = 0
    private(set) var arrayCounter : Int = 0
    
    private(set) var container : String = "배열"

    var totalCounter : Int {
        return stringCounter + intCounter + boolCounter + objectCounter + arrayCounter
    }
    
    init(jsonType: JSONType) {
        if let jsonObject = jsonType as? JSONObject {
            countObjectType(jsonObject: jsonObject)
        } else {
            let jsonArray = jsonType as? JSONArray
            jsonArray?.JSONArray.forEach { countType(item: $0) }
        }
    }
    
    private mutating func countType(item: Any) {
        if item is JSONObject || item is Dictionary<String, Any> {
            objectCounter += 1
        } else if item is JSONArray || item is Array<Any> {
            arrayCounter += 1
        } else if item is String && (item as! String).count != 0 {
            stringCounter += 1
        } else if item is Int {
            intCounter += 1
        } else if item is Bool {
            boolCounter += 1
        }
    }
    
    private mutating func countObjectType(jsonObject: JSONObject) {
        for value in jsonObject.JSONObject.values {
            if value is JSONObject || value is Dictionary<String, Any> {
                objectCounter += 1
            } else if value is JSONArray || value is Array<Any> {
                arrayCounter += 1
            } else if value is String {
                stringCounter += 1
            } else if value is Int {
                intCounter += 1
            } else if value is Bool {
                boolCounter += 1
            }
        }
        container = "객체"
    }
    
}
