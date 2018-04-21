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
    private var objects: [[[String:JSONDataType]]]
    let prefixOfCharacters: String = "문자열 "
    let prefixOfNumbers: String = "숫자 "
    let prefixOfBooleans: String = "부울 "
    let prefixOfObjects: String = "객체 "
    
    init(_ numbers: [Int], _ characters: [String], _ booleans: [Bool], _ objects: [[[String:JSONDataType]]]) {
        self.numbers = numbers
        self.characters = characters
        self.booleans = booleans
        self.objects = objects
    }
    
    func total() -> String {
        // 객체 데이터만 있는 경우
        if numbers.isEmpty && characters.isEmpty && booleans.isEmpty {
            // 객체 데이터로 들어왔을 경우
            if objects.count == 1 {
                return String(objects[0].count) + "개의 객체"
            }
            // 객체가 배열 데이터로 들어왔을 경우
            return String(objects.count) + "개의 배열"
        }
        
        return String(numbers.count + characters.count + booleans.count + objects.count) + "개의"
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
    
    func countObjectValue() -> Int {
        
        for element in objects[0] {
            
        }
        
    }
    
    
}
