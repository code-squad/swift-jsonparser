//
//  JSONData.swift
//  JSONParser
//
//  Created by 김수현 on 2018. 3. 26..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

protocol JSONData {
    func countJSONData() -> String
    func makeJSONData() -> String
}

struct ArrayData {
    var arrayCount = 0
    var objectCount = 0
    var array: [String] = []
    var dictionary: [String:Any] = [:]
    
    init(_ arrayCount: Int, _ objectCount: Int, _ array: [String], _ dictionary: [String:Any]) {
        self.arrayCount = arrayCount
        self.objectCount = objectCount
        self.array = array
        self.dictionary = dictionary
    }
    
}

typealias ObjectData = Dictionary

extension ObjectData: JSONData where Key == String, Value == Any {
    
    func countJSONData() -> String {
        var number = 0
        var string = 0
        var bool = 0
        var array = 0
        
        for i in self.values {
            if i is Int {
                number += 1
            } else if i is String {
                string += 1
            } else if i is Bool {
                bool += 1
            } else if i is Array<Any> {
                array += 1
            }
        }
        
        let allCount = number + string + bool + array
        
        return "총 \(allCount)개의 객체 데이터 중에 \(countOfNumber(number)) \(countOfString(string)) \(countOfBool(bool)) \(countOfArray(array))가 포함되어 있습니다"
        
    }
    
    func makeJSONData() -> String {
        var data = "{"
        for (key, value) in self {
            data += "\n \(key) : \(value),"
        }
        data.removeLast()
        data += "\n}"
        return data
    }
    
    func countOfNumber(_ number: Int) -> String {
        guard number == 0 else { return "숫자 \(number)개" }
        return ""
    }
    
    func countOfString(_ string: Int) -> String {
        guard string == 0 else { return "문자열 \(string)개" }
        return ""
    }
    
    func countOfBool(_ bool: Int) -> String {
        guard bool == 0 else { return "부울 \(bool)개" }
        return ""
    }
    
    func countOfArray(_ array: Int) -> String {
        guard array == 0 else { return "배열 \(array)개" }
        return ""
    }
    
}

extension ArrayData: JSONData {
    
    func countJSONData() -> String {
        return "총 \(arrayCount+objectCount)개의 배열 데이터 중에 \(countArrayOfArray()) \(countOfObject())가 포함되어 있습니다."
    }
    
    func makeJSONData() -> String {
        var data = "["
        if !self.dictionary.isEmpty {
            data += "{"
            for (key, value) in self.dictionary {
                data += "\n \(key) : \(value),"
            }
            data.removeLast()
            data += "\n},\n"
        }
        if !self.array.isEmpty {
            data += "["
            for value in self.array{
                data += value + ","
            }
            data.removeLast()
            data += "],"
        }
        data.removeLast()
        data += "\n]"
        return data
    }
    
    func countArrayOfArray() -> String {
        guard self.arrayCount == 0 else { return "배열 \(self.arrayCount)개" }
        return ""
    }
    
    func countOfObject() -> String {
        guard self.objectCount == 0 else { return "객체 \(self.objectCount)개" }
        return ""
    }
    
}
