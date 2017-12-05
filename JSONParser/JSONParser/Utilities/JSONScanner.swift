//
//  JSONScanner.swift
//  JSONParser
//
//  Created by yuaming on 2017. 12. 5..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONScanner {
    static func makeValues(_ s: String) -> [String] {
        let strings = Utility.removeFromFirstToEnd(in: s)
        var stringIterators: IndexingIterator<String> = strings.makeIterator()
        var stringsCount: Int = strings.count
        var value: String = ""
        var values: [String] = []
        
        while let stringIterator = stringIterators.next() {
            value += String(stringIterator)
            stringsCount -= stringIterator.unicodeScalars.count
            
            if value.contains(JSONDataTypePattern.leftBrace) {
                if value.contains(JSONDataTypePattern.rightBrace) {
                    values.append(value)
                    value = ""
                }
            } else if value.contains(JSONDataTypePattern.leftSquareBracket) {
                if value.contains(JSONDataTypePattern.rightSquareBracket) {
                    values.append(value)
                    value = ""
                }
            } else if value.hasSuffix(JSONDataTypePattern.comma) {
                value.removeLast()
                values.append(value)
                value = ""
            }
            
            if stringsCount == 0 {
                values.append(value)
                value = ""
            }
        }
        
        return values.filter{ $0.isEmpty || $0 == " " ? false : true }
    }
}
