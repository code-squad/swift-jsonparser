//
//  JSONScanner.swift
//  JSONParser
//
//  Created by yuaming on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONScanner {
    private var value: String = ""
    private var values: [String] = []
    
    mutating func makeValues(_ s: String) -> [String] {
        let strings = Utility.removeFromFirstToEnd(in: s)
        var stringsCount: Int = strings.count
        
        for character in strings {
            value += String(character)
            stringsCount -= 1
            
            if value.contains(JSONDataTypePattern.leftBrace) {
                makeObjectValue()
            } else if value.contains(JSONDataTypePattern.leftSquareBracket) {
                makeArrayValue()
            } else if value.hasSuffix(JSONDataTypePattern.comma) {
                makeValue(stringsCount)
            }
            
            if stringsCount == 0 {
                makeValue()
            }
        }
        
        return values.filter{ $0.isEmpty || $0 == " " ? false : true } 
    }
    
    private mutating func makeArrayValue() {
        guard value.contains(JSONDataTypePattern.rightSquareBracket) else {
            return
        }
        
        values.append(value)
        value = ""
    }
    
    private mutating func makeObjectValue() {
        guard value.contains(JSONDataTypePattern.rightBrace) else {
            return
        }
        
        values.append(value)
        value = ""
    }
    
    private mutating func makeValue(_ count: Int) {
        guard count > 0 else {
             return
        }
        
        value.removeLast()
        values.append(value)
        value = ""
    }
    
    private mutating func makeValue() {
        values.append(value)
        value = ""
    }
}
