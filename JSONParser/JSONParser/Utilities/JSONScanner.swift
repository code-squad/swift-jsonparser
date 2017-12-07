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
    
    mutating func makeValues(_ s: String) throws -> [String] {
        let strings = Utility.removeFromFirstToEnd(in: s)
        var stringIterators: IndexingIterator<String> = strings.makeIterator()
        var stringsCount: Int = strings.count
        
        while let stringIterator = stringIterators.next() {
            value += String(stringIterator)
            stringsCount -= stringIterator.unicodeScalars.count
            
            if value.contains(JSONDataTypePattern.leftBrace) {
                try makeObjectValue()
            } else if value.contains(JSONDataTypePattern.leftSquareBracket) {
                try makeArrayValue()
            } else if value.hasSuffix(JSONDataTypePattern.comma) {
                try makeValue(stringsCount)
            }
            
            if stringsCount == 0 {
                try makeValue()
            }
        }
        
        return values.filter{ $0.isEmpty || $0 == " " ? false : true } 
    }
    
    private mutating func makeArrayValue() throws {
        guard value.contains(JSONDataTypePattern.rightSquareBracket) else {
            return
        }
        
        values.append(value)
        value = ""
    }
    
    private mutating func makeObjectValue() throws {
        guard value.contains(JSONDataTypePattern.rightBrace) else {
            return
        }
        
        values.append(value)
        value = ""
    }
    
    private mutating func makeValue(_ count: Int) throws {
        guard count > 0 else {
             return
        }
        
        value.removeLast()
        values.append(value)
        value = ""
    }
    
    private mutating func makeValue() throws {
        values.append(value)
        value = ""
    }
}
