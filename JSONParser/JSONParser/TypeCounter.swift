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
    
    init(jsonData: JSONData) {
        if jsonData.count == 1, let jsonObject = jsonData[0] as? JSONObject {
            countObjectType(jsonObject: jsonObject)
            return
        }
        for item in jsonData {
            countType(item: item)
        }
    }
    
    private mutating func countType(item: Any) {
        if item is JSONObject {
            objectCounter += 1
        } else if item is JSONData {
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
        for item in jsonObject {
            if item.value is JSONObject {
                objectCounter += 1
            } else if item.value is JSONData {
                arrayCounter += 1
            } else if item.value is String {
                stringCounter += 1
            } else if item.value is Int {
                intCounter += 1
            } else if item.value is Bool {
                boolCounter += 1
            }
        }
        container = "객체"
    }
    
}
