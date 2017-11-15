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
    
    init(items: JSONData) {
        if items.count == 1 {
            if items[0] is JSONObject {
                countObjectType(items: items[0] as! JSONObject)
                return
            }
        }
        for item in items {
            countType(item: item)
        }
    }
    
    private mutating func countType(item: Any) {
        if item is JSONObject {
            self.objectCounter += 1
        } else if item is JSONData {
            self.arrayCounter += 1
        } else if item is String && (item as! String).count != 0 {
            self.stringCounter += 1
        } else if item is Int {
            self.intCounter += 1
        } else if item is Bool {
            self.boolCounter += 1
        }
    }
    
    private mutating func countObjectType(items: JSONObject) {
        for item in items {
            if item.value is JSONObject {
                self.objectCounter += 1
            } else if item.value is JSONData {
                self.arrayCounter += 1
            } else if item.value is String {
                self.stringCounter += 1
            } else if item.value is Int {
                self.intCounter += 1
            } else if item.value is Bool {
                self.boolCounter += 1
            }
        }
        self.container = "객체"
    }
    
    func getTotalCount() -> Int {
        return self.stringCounter + self.intCounter + self.boolCounter + self.objectCounter + self.arrayCounter
    }
    
}
