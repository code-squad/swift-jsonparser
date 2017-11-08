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
    private(set) var totalCounter : Int = 0
    
    mutating func countTypes(items: JSONData) {
        for item in items {
            countType(item: item)
        }
        totalCounter = items.count
    }
    
    private mutating func countType(item: Any) {
        if item is Dictionary<String, Any> {
            self.objectCounter += 1
        } else if item is String {
            self.stringCounter += 1
        } else if item is Int {
            self.intCounter += 1
        } else if item is Bool {
            self.boolCounter += 1
        }
    }
}
