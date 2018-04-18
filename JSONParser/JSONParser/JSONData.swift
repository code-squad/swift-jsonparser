//
//  JSONData.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JSONData: JSONPrintable {

    var numbers: [Int]
    var characters: [String]
    var booleans: [Bool]
    
    var total: Int {
        return numbers.count + characters.count + booleans.count
    }
    
    mutating func countCharacters() -> Int {
        return self.characters.count
    }
    
    mutating func countNumbers() -> Int {
        return self.numbers.count
    }
    
    mutating func countBooleans() -> Int {
        return self.booleans.count
    }
    
    var prefixOfCharacters: String {
        return "문자열 "
    }
    
    var prefixOfNumbers: String {
        return "숫자 "
    }
    
    var prefixOfBooleans: String {
        return "부울 "
    }
    
    
}
