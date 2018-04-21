//
//  JSONData.swift
//  JSONParser
//
//  Created by moon on 2018. 4. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum TotalDataType: String {
    case list = "배열"
    case object = "객체"
}

struct JSONData: JSONPrintable {
    
    private var numbers: [Int]
    private var characters: [String]
    private var booleans: [Bool]
    private var objects: [[String:JSONDataType]]
    private let prefixOfCharacters: String = "문자열 "
    private let prefixOfNumbers: String = "숫자 "
    private let prefixOfBooleans: String = "부울 "
    private let prefixOfObjects: String = "객체 "
    
    init(_ numbers: [Int], _ characters: [String], _ booleans: [Bool], _ objects: [[String:JSONDataType]]) {
        self.numbers = numbers
        self.characters = characters
        self.booleans = booleans
        self.objects = objects
    }
    
    func total() -> Int {
        switch totalDataType() {
        case .object:
            return objects[0].count
        case .list:
            return objects.count + numbers.count + booleans.count + characters.count
        }
    }
    
    func totalDataType() -> TotalDataType {
        // 객체 데이터
        if numbers.isEmpty && booleans.isEmpty && characters.isEmpty && objects.count == 1 {
            return TotalDataType.object
        }
        // 배열 데이터
        return TotalDataType.list
    }
    
    private func countCharacters() -> Int {
        return self.characters.count
    }
    
    private func countNumbers() -> Int {
        return self.numbers.count
    }
    
    private func countBooleans() -> Int {
        return self.booleans.count
    }
    
    private func countObjects() -> Int {
        return self.objects.count
    }   
    
    private func getFirstObject() -> [String:JSONDataType] {
        return self.objects[0]
    }
    
    private func countValueOfObject() -> (Int, Int, Int) {
        var countNumbers = 0
        var countBooleans = 0
        var countCharacters = 0
        
        for value in self.objects[0].values {
            switch value {
            case .number:
                countNumbers += 1
            case .boolean:
                countBooleans += 1
            case .characters:
                countCharacters += 1
            default:
                break
            }
        }
        return (countNumbers, countBooleans, countCharacters)
    }
    
    func countValueDescription() -> String {
        var result = ""
        let (numbersCount, booleanCount, charactersCount) = countValueOfObject()
        
        if charactersCount > 0 {
            result += self.prefixOfCharacters
            result += "\(charactersCount)개,"
        }
        
        if numbersCount > 0 {
            result += self.prefixOfNumbers
            result += "\(numbersCount)개,"
        }
        
        if booleanCount > 0 {
            result += self.prefixOfBooleans
            result += "\(booleanCount)개,"
        }
        return result
    }
    
    func countObjectDescription() -> String {
        var result = ""
        result += self.prefixOfObjects
        result += "\(countObjects())개,"
        return result
    }
}
