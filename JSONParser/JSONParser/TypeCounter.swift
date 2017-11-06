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
    
    mutating func countTypes(items: Array<String>) {
        for item in items {
            countType(item: item)
        }
    }
    
    private mutating func countType(item: String) {
        if item.contains("\"") {
            self.stringCounter += 1
        } else if Int(item) != nil {
            self.intCounter += 1
        } else if item.contains("false") || item.contains("true") {
            self.boolCounter += 1
        }
    }
    
    func getTotal() -> Int {
        return stringCounter + intCounter + boolCounter
    }
}
