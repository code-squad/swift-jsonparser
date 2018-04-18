//
//  JSONData.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct JSONData: JSONPrintable {

    private var numbers: [Int]
    private var characters: [String]
    private var booleans: [Bool]
    
    init(_ numbers: [Int], _ characters: [String], _ booleans: [Bool]) {
        self.numbers = numbers
        self.characters = characters
        self.booleans = booleans
    }
    
    var total: Int {
        return numbers.count + characters.count + booleans.count
    }
    
    func countCharacters() -> Int {
        return self.characters.count
    }
    
    func countNumbers() -> Int {
        return self.numbers.count
    }
    
    func countBooleans() -> Int {
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
