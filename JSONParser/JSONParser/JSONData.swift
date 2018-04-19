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
    private var objects: [[String:JSONDataType]]
    let prefixOfCharacters: String = "문자열 "
    let prefixOfNumbers: String = "숫자 "
    let prefixOfBooleans: String = "부울 "
    let prefixOfObjects: String = "객체 "
    
    init(_ numbers: [Int], _ characters: [String], _ booleans: [Bool], _ objects: [[String:JSONDataType]]) {
        self.numbers = numbers
        self.characters = characters
        self.booleans = booleans
        self.objects = objects
    }
    
    var total: Int {
        return numbers.count + characters.count + booleans.count + objects.count
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
    
    func countObjects() -> Int {
        return self.objects.count
    }
}
